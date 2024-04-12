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
    sudo apt install linux-headers-`uname -r`
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
echo "   Press ENTER to continue the Case Study Executing...."
read
cd ..
echo "Starting the SmartHome Simulation"
sudo ln -s /dev/ttyEmulatedPort0 /dev/ttyUSB0
$SIMULIDE house/simulation/LCDFirmwareInSimulator/LCDFirmwareInSimulator.sim1 >> /dev/null  2>> /dev/null &
PIDSIMULIDE=$!
echo "   Please START the simulation and CONNECT the serial port...."
echo "   Press ENTER to continue the Case Study Executing...."
read
cd house
./run.sh &
cd ..
echo "Scenario is executing! Press ENTER to stop."
read
echo "Scenario is executing! Press ENTER (AGAIN) to stop."
read
pkill java 2>> /dev/null
kill -9 $PIDSIMULIDE 2>> /dev/null
sudo rm /dev/ttyUSB0 2>> /dev/null