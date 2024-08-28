class UserPaymentSessionInfo {
  final int userId;
  final double amountPaid;
  final int sessionsAttended;
  final int sessionsRemaining;

  UserPaymentSessionInfo({
    required this.userId,
    required this.amountPaid,
    required this.sessionsAttended,
    required this.sessionsRemaining,
  });

  factory UserPaymentSessionInfo.fromJson(Map<String, dynamic> json) {
    return UserPaymentSessionInfo(
      userId: json['userId'],
      amountPaid: json['amountPaid'].toDouble(),
      sessionsAttended: json['sessionsAttended'],
      sessionsRemaining: json['sessionsRemaining'],
    );
  }
}
