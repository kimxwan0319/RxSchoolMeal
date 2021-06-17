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
  spec.summary          = 'library for get school meal'
  spec.description      = 'library for get school meal'
  spec.homepage         = 'https://github.com/kimxwan0319/RxSchoolMeal'

  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.author           = { 'semicolondsmkr' => 'kimxwan0319@naver.com' }
  spec.source           = { :git => 'https://github.com/kimxwan0319/RxSchoolMeal.git', :tag => spec.version.to_s }
  spec.ios.deployment_target = '13.0'
  spec.source_files = 'RxSchoolMeal/Classes/**/*'
  spec.public_header_files = 'Pod/Classes/**/*.h'

  spec.dependency 'RxAlamofire', '~> 6.1'
  spec.dependency 'RxSwift', '~> 6.0'

  spec.swift_version = '5.0'
end
