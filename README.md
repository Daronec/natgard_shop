# natgard_shop

Натуральные домашние продукты.\n
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/fa706d297c0b43d3954e091d724a2719)](https://app.codacy.com/gh/Daronec/natgard_shop/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade)\n
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
