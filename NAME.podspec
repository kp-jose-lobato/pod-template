Pod::Spec.new do |s|

  # Required fields
  s.name             = '${POD_NAME}'
  s.version          = '0.1.0'
  s.summary          = '${POD_NAME} ${POD_TYPE}.'
  s.homepage         = '${POD_NAME}'
  s.license          = { :type => 'Kape',  :text => 'Kape local pod license.' }
  s.author           = 'Kape'
  s.source           = { :git => '', :tag => s.version.to_s }

  # Platforms
  s.ios.deployment_target = '15.0'
  s.osx.deployment_target = '12.0'


  # Dependencies
  s.dependency 'XVAsset'
  s.dependency 'UIFramework'
  s.dependency 'KPAnalyticsInterface'
  s.dependency 'XVCoordinationRequest'
  s.dependency 'XVEntities'


  # Source files 
  s.source_files = '${POD_NAME}/Sources/**/*'


  # Test
  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = '${POD_NAME}/Tests/**/*'
    test_spec.requires_app_host = true
    test_spec.dependency 'Cuckoo'
    test_spec.dependency 'Cuckoo/OCMock'
    test_spec.dependency 'KPAnalyticsMocks'
  end

  # Touch the generated file so that we do not need to add it in git.
  # Only runs on the first download/install of this pod
  s.prepare_command = <<-CMD
    touch ../${POD_NAME}/${POD_NAME}/Tests/Mocks/${POD_NAME}-Mocks.generated.swift
  CMD

  # Generate the mocks on every build
  s.script_phase = { :name => 'Cuckoo Mock Generator',
        :script => 'cd "$(git rev-parse --show-toplevel 2>/dev/null)"/Features ; sh ${POD_NAME}/CuckooMockGenerator.sh',
        :execution_position => :before_compile}

end
