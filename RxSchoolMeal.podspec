#
# Be sure to run `pod lib lint RxSchoolMeal.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |spec|
  spec.name             = 'RxSchoolMeal'
  spec.version          = ENV['LIB_VERSION']
  spec.summary          = 'RxLibrary for get school meal'
  spec.description      = 'This is awsome library for get school meal with RxSwift'
  spec.homepage         = 'https://github.com/kimxwan0319/RxSchoolMeal'

  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.author           = { 'semicolondsmkr' => 'kimxwan0319@naver.com' }
  spec.source           = { :git => 'https://github.com/kimxwan0319/RxSchoolMeal.git', :tag => spec.version.to_s }
  spec.ios.deployment_target = '12.0'
  spec.osx.deployment_target = '10.12'
  spec.watchos.deployment_target = '6.0'
  
  spec.source_files  = 'Sources/RxSchoolMeal/**/*', 'Sources/RxSchoolMeal/*'

  spec.dependency 'RxAlamofire', '~> 6.1'
  spec.dependency 'RxSwift', '~> 6.0'

  spec.swift_version = '5.0'
end
