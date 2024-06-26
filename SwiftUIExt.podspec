Pod::Spec.new do |s|
  s.name             = 'SwiftUIExt'
  s.version          = '1.0.0'

  s.summary          = s.name
  s.homepage         = 'https://github.com/cuzv'
  s.license          = 'MIT'
  s.author           = 'Shaw'
  s.source           = { :path => '.' }

  s.ios.deployment_target = '13.0'
  s.swift_versions = '5.9'
  s.source_files = 'Sources/**/*.swift'

  s.resource_bundles = {
    'SwiftUIExt' => ['Resources/PrivacyInfo.xcprivacy']
  }
end
