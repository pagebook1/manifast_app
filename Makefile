## Setup Command ----------------------------------------------------------------

build_apk = fvm flutter build apk --shrink --obfuscate --split-debug-info=1.0.0

ensure_flutter_version: ## Install and use required flutter version for the project 
	fvm install 3.22.3
	fvm use 3.22.3

create_project: ## Install the flutter project
	fvm flutter create .

clean: ## Clean the flutter project
	fvm flutter clean
	fvm flutter pub get

pubs: ## Gets all the flutter packages
	fvm flutter pub get && fvm flutter pub get

build_runner: 
	fvm dart run build_runner build 

build_runner_watch: 
	fvm flutter pub run build_runner watch --delete-conflicting-outputs

format: 
	fvm dart format lib test

rebuild: ## Rebuild the project
	ensure_flutter_version pubs build_runner format

build_dev_web : ## Create dev web build
	fvm flutter build web --dart-define=FLAVOR=dev --target lib/main_dev.dart --web-renderer canvaskit
	firebase deploy --only hosting

build_staging_web : ## Create staging web build
	fvm flutter build web --flavor --dart-define=FLAVOR=staging --target lib/main_staging.dart --web-renderer canvaskit
	firebase deploy --only hosting

build_dev_apk: ## Create dev APK
	${build_apk} --flavor dev --target lib/main_dev.dart

build_staging_apk: ## Create staging APK
	${build_apk} --flavor staging --target lib/main_staging.dart
	
## Do not use this if you will going to test the app
## Use either [build_dev_apk] or [build_staging_apk]
build_prod_apk: ## Create prod APK
	${build_apk} --flavor prod --target lib/main_prod.dart

update_ios_pods:
	cd ios && pod repo update && pod install

build_ios: ## Create iOS build
	fvm flutter build ios -v

setup_database: ## Setup firebase database for dev and staging after dev finished, quit the process to run staging
	fvm flutter run lib/FirebaseSetup/setupFirebaseDev.dart
	fvm flutter run lib/FirebaseSetup/setupFirebaseStaging.dart

run_dev:
	fvm flutter run -d chrome --flavor dev --target lib/main_dev.dart --web-renderer canvaskit

run_staging:
	fvm flutter run -d chrome --flavor staging --target lib/main_staging.dart --web-renderer canvaskit