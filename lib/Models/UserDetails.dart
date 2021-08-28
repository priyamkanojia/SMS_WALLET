import 'package:flutter/material.dart';

class UserDetails {
  static String id;
 static String fullname;
 static String username;
 static String gender;
 static String email;
 static String mobile;
 static String dob;
 static String emailVerifiedAt;
 static String password;
 static String socialId;
 static String loginType;
 static String city;
 static String state;
 static String address;
 static String country;
 static String isActive;
 static String isKycDone;
 static String apiToken;
 static String referalcode;
 static String referedCode;
 static String profileImage;
 static String rememberToken;
 static String interest;
 static String createdAt;
 static String updatedAt;
 static String task;
static String user_badge;
////// below veriables are for other purposes -------- not for profile

 static bool isOtpVerificationOn;
static bool kycPopShowed;
static int profileStatus = 0;
static int perStatePercent = 8;
static int kyCStatePercent = 20;
static List<Widget> lstProfileStatus=[];

  UserDetails(
      { id,
 fullname,
 username,
 email,
       gender,
 mobile,
 dob,
 emailVerifiedAt,
 password,
 socialId,
 loginType,
       country,
 city,
 state,
 address,
 interest,
 isActive,
 isKycDone,
 apiToken,
 referalcode,
 referedCode,
 profileImage,
 rememberToken,
 createdAt,
 updatedAt,
 user_badge,
 task});

  UserDetails.fromJson(Map<String, dynamic> json) {
    profileStatus=0;
   id = json['id'];

    fullname = json['fullname'];
    if(fullname!=null && fullname!="")
    {
      profileStatus=profileStatus+perStatePercent;
    }
    username = json['username'];
    if(username!=null && username!="")
    {
      profileStatus=profileStatus+perStatePercent;
    }
    gender = json['gender'];
    if(gender!=null && gender!="")
    {
     profileStatus=profileStatus;
    }
    email = json['email'];
    if(email!=null && email!="")
    {
      profileStatus=profileStatus+perStatePercent;
    }
    mobile = json['mobile'];
    if(mobile!=null && mobile!="")
    {
      profileStatus=profileStatus+perStatePercent;
    }
    dob = json['dob'];
    if(dob!=null && dob!="")
    {
      profileStatus=profileStatus+perStatePercent;
    }
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    interest= json['intrest'];

    socialId = json['social_id'];
    loginType = json['login_type'];
    country = json['country'];
    if(country!=null && country!="")
    {
     profileStatus=profileStatus;
    }
    city = json['city'];
     if(city!=null && city!="")
    {
      profileStatus=profileStatus+perStatePercent;
    }
    state = json['state'];
     if(state!=null && state!="")
    {
      profileStatus=profileStatus+perStatePercent;
    }
    address = json['address'];
     if(address!=null && address!="")
    {
      profileStatus=profileStatus+perStatePercent;
    }

    if(interest!=null && interest!="")
    {
     profileStatus=profileStatus+perStatePercent;
    }
    isActive = json['isActive'];
    isKycDone = json['is_kyc_done'];
    if(isKycDone!=null && isKycDone!="0")
    {
      profileStatus=profileStatus+kyCStatePercent;
    }
    apiToken = json['api_token'];
    referalcode = json['referalcode'];
    referedCode = json['refered_code'];
    profileImage = json['profile_image'];
     if(profileImage!=null && profileImage!="")
    {
      profileStatus=profileStatus+perStatePercent;
    }
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    task = json['task'];
        user_badge = json['user_badge'];

    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   data['id'] = id;
    data['fullname'] = fullname;
    data['username'] = username;
    data['gender'] = gender;
    data['email'] = email;
    data['mobile'] = mobile;
    data['dob'] = dob;
    data['email_verified_at'] = emailVerifiedAt;
    data['password'] = password;
    data['social_id'] = socialId;
    data['login_type'] = loginType;
    data['country']= country;
    data['city'] = city;
    data['state'] = state;
    data['address'] = address;
    data['isActive'] = isActive;
    data['isActive'] = isActive;
    data['is_kyc_done'] = isKycDone;
    data['api_token'] = apiToken;
    data['referalcode'] = referalcode;
    data['refered_code'] = referedCode;
    data['profile_image'] = profileImage;
    data['remember_token'] = rememberToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['task'] = task;
    data['intrest'] = interest;
    return data;
  }
}