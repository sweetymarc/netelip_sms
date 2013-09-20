Gem::Specification.new do |s|
  s.name          = 'netelip_sms'
  s.version       = '0.1.0'
  s.date          = '2013-09-20'
  s.summary       = 'Netelip send SMS HTTP gateway'
  s.description   = 'A gateway to send SMS using HTTP POST, through Netelip service, written in ruby'
  s.files         = ['lib/netelip_sms.rb']
  s.require_path  ='lib'
  s.author        = 'Angel García Pérez'
  s.email         = 'wage83@gmail.com'
  s.homepage      = 'http://netelip.es/downloads/manuales/netelip_api_sms.pdf'
  s.has_rdoc      = false

  s.add_dependency('phone', '1.0')
  s.add_development_dependency('rake', '~> 0.8.7')
  s.add_development_dependency('rspec', '>1.3.1')
end
