import 'package:equatable/equatable.dart';
import 'package:warehouse_app/models/supervisor.dart';

import 'current_attendance.dart';

class Profile extends Equatable {
  final String? payroll;
  final String? section;
  final String? line;
  final String? assignmentId;
  final String? supervisorPersonId;
  final String? empNo;
  final String? empName;
  final String? designation;
  final String? personCategory;
  final String? dept;
  final String? org;
  final String? orgId;
  final String? joiningDate;
  final String? nid;
  final String? dob;
  final String? blood;
  final String? email;
  final String? salary;
  final String? clAvail;
  final String? mlAvail;
  final String? elAvail;
  final String? mtlAvail;
  final String? clBlnc;
  final String? mlBlnc;
  final String? elBlnc;
  final String? bengaliName;
  final String? payrollId;
  final String? personId;
  final String? amEmpNo;
  final String? phoneNo;
  final CurrentAttendance? currentAttendance;
  final Supervisor? supervisor;

  const Profile({
    this.payroll,
    this.section,
    this.line,
    this.assignmentId,
    this.supervisorPersonId,
    this.empNo,
    this.empName,
    this.designation,
    this.personCategory,
    this.dept,
    this.org,
    this.orgId,
    this.joiningDate,
    this.nid,
    this.dob,
    this.blood,
    this.email,
    this.salary,
    this.clAvail,
    this.mlAvail,
    this.elAvail,
    this.mtlAvail,
    this.clBlnc,
    this.mlBlnc,
    this.elBlnc,
    this.bengaliName,
    this.payrollId,
    this.personId,
    this.amEmpNo,
    this.currentAttendance,
    this.supervisor,
    this.phoneNo,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        payroll: json['PAYROLL'] as String?,
        section: json['SECTION'] as String?,
        line: json['LINE'] as String?,
        assignmentId: json['ASSIGNMENT_ID'] as String?,
        supervisorPersonId: json['SUPERVISOR_PERSON_ID'] as String?,
        empNo: json['EMP_NO'] as String?,
        empName: json['EMP_NAME'] as String?,
        designation: json['DESIGNATION'] as String?,
        personCategory: json['PERSON_CATEGORY'] as String?,
        dept: json['DEPT'] as String?,
        org: json['ORG'] as String?,
        orgId: json['ORG_ID'] as String?,
        joiningDate: json['JOINING_DATE'] as String?,
        nid: json['NID'] as String?,
        dob: json['DOB'] as String?,
        blood: json['BLOOD'] as String?,
        email: json['EMAIL'] as String?,
        salary: json['SALARY'] as String?,
        clAvail: json['CL_AVAIL'] as String?,
        mlAvail: json['ML_AVAIL'] as String?,
        elAvail: json['EL_AVAIL'] as String?,
        mtlAvail: json['MTL_AVAIL'] as String?,
        clBlnc: json['CL_BLNC'] as String?,
        mlBlnc: json['ML_BLNC'] as String?,
        elBlnc: json['EL_BLNC'] as String?,
        bengaliName: json['BENGALI_NAME'] as String?,
        payrollId: json['PAYROLL_ID'] as String?,
        personId: json['PERSON_ID'] as String?,
        amEmpNo: json['AM_EMP_NO'] as String?,
        phoneNo: json["PHONE_NUMBER"] as String?,
        currentAttendance: json['CURRENT_ATTENDANCE'] == null
            ? null
            : CurrentAttendance.fromJson(
                json['CURRENT_ATTENDANCE'] as Map<String, dynamic>),
        supervisor: json['SUPERVISOR_INFO'] == null
            ? null
            : Supervisor.fromJson(
                json['SUPERVISOR_INFO'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'PAYROLL': payroll,
        'SECTION': section,
        'LINE': line,
        'ASSIGNMENT_ID': assignmentId,
        'SUPERVISOR_PERSON_ID': supervisorPersonId,
        'EMP_NO': empNo,
        'EMP_NAME': empName,
        'DESIGNATION': designation,
        'PERSON_CATEGORY': personCategory,
        'DEPT': dept,
        'ORG': org,
        'ORG_ID': orgId,
        'JOINING_DATE': joiningDate,
        'NID': nid,
        'DOB': dob,
        'BLOOD': blood,
        'EMAIL': email,
        'SALARY': salary,
        'CL_AVAIL': clAvail,
        'ML_AVAIL': mlAvail,
        'EL_AVAIL': elAvail,
        'MTL_AVAIL': mtlAvail,
        'CL_BLNC': clBlnc,
        'ML_BLNC': mlBlnc,
        'EL_BLNC': elBlnc,
        'BENGALI_NAME': bengaliName,
        'PAYROLL_ID': payrollId,
        'PERSON_ID': personId,
        'AM_EMP_NO': amEmpNo,
        'PHONE_NUMBER': phoneNo,
        'CURRENT_ATTENDANCE': currentAttendance,
        'SUPERVISOR_INFO': supervisor,
      };

  @override
  List<Object?> get props {
    return [
      payroll,
      section,
      line,
      assignmentId,
      supervisorPersonId,
      empNo,
      empName,
      designation,
      personCategory,
      dept,
      org,
      orgId,
      joiningDate,
      nid,
      dob,
      blood,
      email,
      salary,
      clAvail,
      mlAvail,
      elAvail,
      mtlAvail,
      clBlnc,
      mlBlnc,
      elBlnc,
      bengaliName,
      payrollId,
      personId,
      amEmpNo,
      phoneNo,
      currentAttendance,
      supervisor,
    ];
  }
}
