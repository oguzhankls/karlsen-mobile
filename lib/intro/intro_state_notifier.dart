import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'intro_data_notifier.dart';
import 'intro_types.dart';

class IntroStateNotifier extends StateNotifier<IntroState> {
  final IntroDataNotifier introData;

  IntroStateNotifier(this.introData) : super(IntroState.init());

  void newWallet() {
    introData.generateNewMnemonic();

    _goToPage(IntroPage.walletName);
  }

  void importSelect() {
    _goToPage(IntroPage.importSelect);
  }

  void importWalletLegacyDerivation() {
    _goToPage(IntroPage.importSeedLegacyDerivation);
  }

  void importWallet() {
    _goToPage(IntroPage.importSeed);
  }

  void importLegacyWallet() {
    _goToPage(IntroPage.importLegacySeed);
  }

  void importViewOnlyWallet() {
    _goToPage(IntroPage.importKpub);
  }

  void skipPassword() {
    if (introData.isSeedGenerated) {
      _goToPage(IntroPage.backupSafety);
    } else {
      introData.complete();
    }
  }

  void showIntroPassword() {
    _goToPage(IntroPage.password);
  }

  void setName(String name) {
    introData.setName(name);
    if (introData.skipPassword) {
      skipPassword();
      return;
    }

    _goToPage(IntroPage.passwordOnLaunch);
  }

  void setPassword(String password) {
    introData.setPassword(password);

    if (introData.isSeedGenerated) {
      _goToPage(IntroPage.backupSafety);
    } else {
      introData.complete();
    }
  }

  void setMnemonic(String mnemonic, {String? walletName, bool legacy = false}) {
    if (walletName != null) {
      introData.setName(walletName);
    }
    introData.setMnemonic(mnemonic, legacy: legacy);
    _goToPage(IntroPage.walletName);
  }

  void setKpub(String kpub) {
    introData.setKpub(kpub);
    _goToPage(IntroPage.walletName);
  }

  void showIntroBackup() {
    _goToPage(IntroPage.backupSeed);
  }

  void showIntroBackupConfirm() {
    _goToPage(IntroPage.backupConfirm);
  }

  void showIntroWalletName() {
    _goToPage(IntroPage.walletName);
  }

  void goBack() {
    state = IntroState.pop();
  }

  void _goToPage(IntroPage page) {
    state = IntroState.push(page: page);
  }
}
