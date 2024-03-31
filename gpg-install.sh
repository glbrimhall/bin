sudo apt install git git-remote-gcrypt gnupg rclone

exit

# From https://alexcabal.com/creating-the-perfect-gpg-keypair
# gpg create commands:

gpg --full-generate-key <email_addr>
gpg --edit-key <email_addr> # in prompt addphoto
gpg --edit-key <email_addr> # in prompt adduid  for additional email_addr
gpg --output <email_addr>.master-gpg-revocation-certificate --gen-revoke <email_addr>
gpg --edit-key <email_addr> # in prompt addkey, select option 4 for each laptop. 
gpg --export-secret-keys --armor <email_addr>.master-private.gpg-key
gpg --export --armor <email_addr>.master-public.gpg-key
gpg --list-secret-keys <email_addr>
# to get fingerprint
gpg --fingerprint < <email_addr>.master-public.gpg-key
gpg --show-keys < <email_addr>.master-public.gpg-key

# gpg subkey for laptop
gpg --edit-key <email_addr> # in prompt delkey 
gpg --export-secret-subkeys --armor <email_addr>.master-private.gpg-key


