# natgard_shop

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/16f99ddf915647a7b58ba9cd464cac6b)](https://app.codacy.com/gh/Daronec/natgard_shop?utm_source=github.com&utm_medium=referral&utm_content=Daronec/natgard_shop&utm_campaign=Badge_Grade)

Натуральные домашние продукты.

flutter create --org ru.natgard client_mobile --platforms android, ios
flutter create --org ru.natgard admin_web --platforms web
flutter create --org ru.natgard client_web --platforms web

## Установка melos `dart pub global activate melos`
--если не определён SDK Flutter в системе, необходимо выполнить:
export PATH="$PATH:/../flutter/bin" // где /../flutter/bin - путь к SDK Flutter
--если не определён SDK Dart в системе, необходимо выполнить:
export PATH="$PATH:/../flutter/bin/cache/dart-sdk/bin" // где /../flutter/bin/cache/dart-sdk/bin - путь к SDK Dart
export PATH="$PATH:$HOME/.pub-cache/bin"

export PATH="$PATH:/../flutter/bin"; export PATH="$PATH:/../flutter/bin/cache/dart-sdk/bin"; export PATH="$PATH:$HOME/.pub-cache/bin"; dart pub global activate melos; melos bs

Перед началом работы выполнить `melos bs` для инициализации melos