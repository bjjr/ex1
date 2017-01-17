start transaction;

use `Acme-Pad-Thai`;

revoke all privileges on `Acme-Pad-Thai`.* from 'acme-user'@'%';
revoke all privileges on `Acme-Pad-Thai`.* from 'acme-manager'@'%';

drop user 'acme-user'@'%';
drop user 'acme-manager'@'%';

drop database `Acme-Pad-Thai`;

commit;