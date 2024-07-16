= RECUPERANDO GRUB DO UBUNTU SERVER =

== Sintomas ==

* Erro ao inicializar o sistema com "unknown filesystem"

== Passos ==

* Use uma iso do linux desktop do ubuntu
* Monte a unidade que contém o /boot
* Mounte o disco:
	
	sudo mount /dev/sdaX /mnt
	
* Faça um bind:
	
	for i in /sys /proc /run /dev; do sudo mount --rbind "$i" "/mnt$i"; done
	
* Se tiver efi, monte o /mnt/boot/efi
* Chroot nisso aí:

	sudo chroot /mnt

* Atualize o grub:

	update-grub
	
* Se o bicho pegar, é melhor usar isso aqui:

	grub-install /dev/sda
	update-grub
	
* Se tiver efi na jogada:

	blkid | grep -i efi
	grep -i efi /etc/fstab
	
* Só correr para o abraço:

	exit
	sudo reboot
	
	
