# clear display
Clear-Host

# ensure virtual machine is fresh
multipass delete k3s
multipass purge

# create and start virtual machine
multipass launch --name k3s --cpus 2 --mem 2G --disk 5G
