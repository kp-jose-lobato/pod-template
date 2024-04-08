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
  s.ios.deployment_target = '10.0'


  # Dependencies
  # remove this line and add dependencies if needed


  # Source files 
  s.source_files = '${POD_NAME}/Classes/**/*'


  # Test
end
