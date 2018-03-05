name 'firebolt'
maintainer 'iDT Labs'
maintainer_email 'ukhaliq@idtlabs.xyz'
license 'Apache 2.0'
description 'Installs/Configures firebolt on opswork'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.2'

depends 'idt_infra_tools'
depends 'java'
depends 'supervisor'
depends 'tar'
depends 'aws'

%w{ ubuntu }.each do |os|
  supports os
end
