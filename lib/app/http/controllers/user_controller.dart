import 'dart:io';

import 'package:food_store_backend/app/models/user.dart';
import 'package:vania/vania.dart';

class UserController extends Controller {
  //! Register new user
  Future<Response> register(Request request) async {
    request.validate({
      'user_name': 'required|string',
      'email': 'required|email',
      'password': 'required',
      'avatar': 'file:jpg,jpeg,png',
    }, {
      'user_name.required': 'The user name is required',
      'email.required': 'The email is required',
      'email.email': 'The email is not valid',
      'password.required': 'The password is required',
      'avatar.file': 'The avatar must be an image file',
    });

    /// Checking if the user already exists
    Map<String, dynamic>? user = await User()
        .query()
        .where('email', '=', request.input('email'))
        .first();
    if (user != null) {
      return Response.json({'message': 'User already exists'});
    }

    RequestFile? avatar = request.file('avatar');
    String? avatarPath;
    if (avatar != null) {
      avatarPath = await avatar.store(
          path: 'users/${Auth().id()}', filename: avatar.filename);
    }

    await User().query().insert({
      'user_name': request.input('user_name'),
      'email': request.input('email'),
      'password': Hash().make(request.input('password').toString()),
      'avatar': avatarPath,
      'created_at': DateTime.now(),
      'updated_at': DateTime.now(),
    });

    return Response.json(
      {'message': 'User created successfully'},
      HttpStatus.created,
    );
  }

//! Register new admin
  Future<Response> registerAdmin(Request request) async {
    request.validate({
      'user_name': 'required|string',
      'email': 'required|email',
      'password': 'required',
      'avatar': 'file:jpg,jpeg,png',
    }, {
      'user_name.required': 'The user name is required',
      'email.required': 'The email is required',
      'email.email': 'The email is not valid',
      'password.required': 'The password is required',
      'avatar.file': 'The avatar must be an image file',
    });

    /// Checking if the user already exists
    Map<String, dynamic>? user = await User()
        .query()
        .where('email', '=', request.input('email'))
        .first();
    if (user != null) {
      return Response.json({'message': 'User already exists'});
    }

    RequestFile? avatar = request.file('avatar');
    String? avatarPath;
    if (avatar != null) {
      avatarPath = await avatar.store(
          path: 'users/${Auth().id()}', filename: avatar.filename);
    }

    await User().query().insert({
      'user_name': request.input('user_name'),
      'email': request.input('email'),
      'is_admin': 1,
      'password': Hash().make(request.input('password').toString()),
      'avatar': avatarPath,
      'created_at': DateTime.now(),
      'updated_at': DateTime.now(),
    });

    return Response.json(
      {'message': 'User created successfully'},
      HttpStatus.created,
    );
  }

//! Login
  Future<Response> login(Request request) async {
    request.validate({
      'email': 'required|email',
      'password': 'required',
    }, {
      'email.required': 'The email is required',
      'email.email': 'The email is not valid',
      'password.required': 'The password is required',
    });

    Map<String, dynamic>? user = await User()
        .query()
        .where('email', '=', request.input('email'))
        .first();
    if (user == null) {
      return Response.json(
        {'message': 'User not found'},
        HttpStatus.notFound,
      );
    }
    final password = request.input('password').toString();

    if (!Hash().verify(password, user['password'].toString())) {
      return Response.json(
        {'message': 'Invalid password'},
        HttpStatus.badRequest,
      );
    }
    final token = await Auth().login(user).createToken(
        expiresIn: const Duration(days: 1), withRefreshToken: true);

    return Response.json(token);
  }

  Future<Response> show() async {
    final user = await User()
        .query()
        .where('id', '=', Auth().id())
        .whereNull('deleted_at')
        .select([
      'id',
      'user_name',
      'email',
      'avatar',
      'created_at',
      'updated_at',
      'deleted_at',
    ]).first();
    if (user == null) {
      return Response.json(
        {'message': 'User not found'},
        HttpStatus.notFound,
      );
    }
    return Response.json(user);
  }

//! Update
  Future<Response> update(Request request) async {
    final user = await User()
        .query()
        .where('id', '=', Auth().id())
        .whereNull('deleted_at')
        .first();
    if (user == null) {
      return abort(HttpStatus.notFound, 'User not found');
    }

    final existedUser = await User()
        .query()
        .where('email', '=', request.input('email'))
        // .whereNull('deleted_at')
        .first();
    if (existedUser != null) {
      return Response.json(
        {'message': 'The email already exists'},
        HttpStatus.badRequest,
      );
    }

    RequestFile? avatar = request.file('avatar');
    String? avatarPath;
    if (avatar != null) {
      avatarPath = await avatar.store(
          path: 'users/${Auth().id()}', filename: avatar.filename);
    }
    await User()
        .query()
        .where('id', '=', Auth().id())
        .whereNull('deleted_at')
        .update({
      'user_name': request.input('user_name') ?? user['user_name'],
      'email': request.input('email') ?? user['email'],
      'avatar': avatarPath ?? user['avatar'],
      'updated_at': DateTime.now()
    });

    return Response.json({
      'message': 'User updated successfully',
    });
  }

//! Destroy
  Future<Response> destroy() async {
    await User().query().where('id', '=', Auth().id()).update({
      'deleted_at': DateTime.now(),
    });
    await Auth().deleteTokens();
    return Response.json({
      'message': 'User deleted successfully',
    });
  }
}

final UserController userController = UserController();
