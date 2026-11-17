import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dermalyze/src/features/auth/access_control.dart';

/// Perfil de um profissional, como está em `users/{uid}` no Firestore.
class UserProfile {
  final String name;

  /// [kRoleAgent] ou [kRoleDoctor].
  final String role;

  /// Liberado pelo Padtech no Console.
  final bool approved;

  const UserProfile({required this.name, required this.role, required this.approved});

  factory UserProfile.fromMap(Map<String, dynamic> data) {
    return UserProfile(
      name: (data['name'] as String?) ?? '',
      role: (data['role'] as String?) ?? '',
      approved: data['approved'] == true,
    );
  }

  /// Só entra no app quem foi liberado e tem um perfil válido. Um `role`
  /// digitado errado no Console bloqueia o acesso em vez de virar agente.
  bool get canAccess => approved && (role == kRoleAgent || role == kRoleDoctor);
}

/// Acesso ao perfil dos profissionais no Firestore.
///
/// Nenhum dado de paciente passa por aqui: o Firestore guarda apenas quem pode
/// usar o app e com qual perfil.
class UserProfileRepository {
  final FirebaseFirestore _firestore;

  UserProfileRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  DocumentReference<Map<String, dynamic>> _doc(String uid) =>
      _firestore.collection('users').doc(uid);

  /// Lê o perfil direto do servidor, ignorando o cache local, para que uma
  /// liberação ou troca de perfil feita no Console valha no login.
  ///
  /// Retorna `null` quando a conta ainda não tem perfil.
  Future<UserProfile?> fetchProfile(String uid) async {
    final snapshot = await _doc(uid).get(const GetOptions(source: Source.server));
    final data = snapshot.data();
    return data == null ? null : UserProfile.fromMap(data);
  }

  /// Cria o perfil sempre pendente de liberação. As regras do Firestore
  /// recusam qualquer outro formato, e o e-mail precisa ser o da conta logada.
  Future<void> createProfile({
    required String uid,
    required String name,
    required String email,
    required String role,
  }) {
    return _doc(uid).set({
      'name': name,
      'email': email,
      'role': role,
      'approved': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Acompanha o perfil em tempo real, para aplicar na hora uma revogação ou
  /// troca de perfil feita no Console.
  ///
  /// Só repassa o que veio do servidor: um snapshot do cache local pode estar
  /// vazio ou desatualizado e não pode encerrar a sessão por engano. Emite
  /// `null` quando o documento foi apagado.
  Stream<UserProfile?> watchProfile(String uid) {
    return _doc(uid)
        .snapshots(includeMetadataChanges: true)
        .where((snapshot) => !snapshot.metadata.isFromCache)
        .map((snapshot) {
      final data = snapshot.data();
      return data == null ? null : UserProfile.fromMap(data);
    });
  }
}
