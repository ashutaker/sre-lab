
IMAGE_NAME="ubuntu-24.04-minimal-cloudimg-amd64.img"

#download the ubuntu image
if [! -f /root/$IMAGE_NAME ]; then
    wget https://cloud-images.ubuntu.com/minimal/releases/noble/release/$IMAGE_NAME
fi

# resize disk size
qemu-img resize $IMAGE_NAME 20G

# download the virt-customise tool 
apt update -y && apt install libguestfs-tools -y

# add qemu-guest-agent using virt-customise
virt-customize -a $IMAGE_NAME --install qemu-guest-agent

VM_ID=1000
TEMPLATE_NAME="ubuntu-2404-base-template"

# Create new VM with the image and set it up
qm create $VM_ID --name $TEMPLATE_NAME --memory 2048 -net0 virtio,bridge=vmbr0 --scsihw virtio-scsi-single 
qm set $VM_ID --scsi0 local:0,import-from=/root/$IMAGE_NAME

# set cloudinit drive
qm set $VM_ID --ide2 local:cloudinit

# display option
qm set $VM_ID --serial0 socket --vga serial0

# set boot disk
qm set $VM_ID --boot c --bootdisk scsi0

qm template $VM_ID
