#! /bin/bash
SIMULIDE="/opt/chonos-embMAS/lib/simulide/simulide"
SERIALEMULATOR="/opt/chonos-embMAS/lib/SerialPortEmulator/virtualbot"
JASONEMBEDDED="/opt/chonos-embMAS/lib/jason/jasonEmbedded.jar"
clear

if [ ! -f "$SIMULIDE"  ] ||  [ ! -f "$SERIALEMULATOR" ] ||  [ ! -f "$JASONEMBEDDED" ]
then
    echo "Preparing System"
    echo "deb [trusted=yes] http://packages.chon.group/ chonos main" | sudo tee /etc/apt/sources.list.d/chonos.list
    sudo apt update
    sudo apt install chonos-serial-port-emulator chonos-embeddedmas chonos-simulide
    echo "Installation complete. Rebooting system..."
    sleep 10
    sudo reboot
else
    echo "The computer has JasonEmbedded, SimulIDE and ChonOS-Serial-Port-Emulator"
fi

echo "Starting the CivilDefense MAS"
cd civilDefense 
./run.sh &
echo "   Press ENTER to continue the Case Study Executing...."
read
echo "Starting the CityHall MAS"
cd ..
cd cityHall 
./run.sh &
read
echo "   Press ENTER to continue the Case Study Executing...."
cd ..
echo "Starting the SmartHome Simulation"
$SIMULIDE house/simulation/LCDFirmwareInSimulator/LCDFirmwareInSimulator.sim1 &
sleep 5
echo "   Please START the simulation and CONNECT the serial port...."
echo "   Press ENTER to continue the Case Study Executing...."
read
cd house
sleep 5
./run.sh &
cd ..
