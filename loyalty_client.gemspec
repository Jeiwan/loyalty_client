Gem::Specification.new do |s|
  s.name        = 'loyalty_client'
  s.version     = '1.0.0'
  s.license     = 'MIT'
  s.summary     = 'Client for Loyalty API'
  s.description = 'Client for Loyalty API'
  s.authors     = ['Ivan Kuznetsov']
  s.email       = 'me@jeiwan.ru'
  s.files       = Dir['lib/**/*.rb']
  s.test_files  = Dir['spec/**/*']
  s.homepage    = 'https://github.com/Jeiwan/loyalty_client'
  
  s.add_runtime_dependency 'savon'
  s.add_development_dependency 'rspec', '~> 3.0.0'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'vcr'
end
