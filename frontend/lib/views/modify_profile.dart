import 'package:danim/view_models/app_view_model.dart';
import 'package:danim/view_models/modify_profile_view_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModifyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (context, appViewModel, _) {
        return ChangeNotifierProvider<ModifyProfileViewModel>(
          create: (_) => ModifyProfileViewModel(
            appViewModel.userInfo.profileImageUrl,
            appViewModel.userInfo.nickname,
          ),
          child: Consumer<ModifyProfileViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Stack(children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: viewModel.selectedImageFile != null
                          ? FileImage(viewModel.selectedImageFile)
                          : null,
                      child: viewModel.selectedImageFile == null
                          ? ExtendedImage.network(
                              viewModel.imagePath,
                              shape: BoxShape.circle,
                              cache: true,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30.0)),
                            )
                          : null,
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            viewModel.changeProfileImage();
                          },
                          child: const Icon(
                            Icons.settings,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ))
                  ]),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: SizedBox(
                      height: 80,
                      child: TextField(
                        controller: viewModel.textEditController,
                        onChanged: (value) {
                          viewModel.nickname = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Enter your nickname',
                          errorText:
                              !viewModel.isValid ? 'Invalid Nickname' : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, // text color
                          backgroundColor: Colors.blue, // button color
                        ),
                        onPressed: !viewModel.isValid
                            ? null
                            : () {
                                viewModel.sendModifyProfile(
                                    context, appViewModel);
                              },
                        child: const Text('수정'),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
