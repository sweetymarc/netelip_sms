Gem::Specification.new do |s|
  s.name          = 'netelip_sms'
  s.version       = '0.3.2'
  s.date          = '2018-06-20'
  s.summary       = 'Netelip send SMS HTTP gateway'
  s.description   = 'A gateway to send SMS using HTTPS POST, through Netelip service, written in ruby'
  s.license       = 'GPL-3.0'
  s.files         = ['lib/netelip_sms.rb']
  s.require_path  ='lib'
  s.author        = 'Angel García Pérez'
  s.email         = 'wage83@gmail.com'
  s.homepage      = 'https://static.netelip.com/downloads/manuales/netelip_api_sms.pdf'
  s.has_rdoc      = false

  s.add_dependency 'global_phone', '~> 1.0', '>= 1.0.1'
  s.add_dependency 'activesupport', '~> 0'
  s.add_development_dependency 'rake', '~> 10.0', '>= 10.0.0'
  s.add_development_dependency 'rspec', '~> 3.7', '>= 3.7.0'
  s.add_development_dependency('json', '1.8.6')
end
