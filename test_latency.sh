DELAYS=(0 50 100 200 300 400 500 700 850 1000 1150 1300 1500 1700 2500 3500 5000 20000 40000 80000)
OUTPUT_PATH="./mlc-outputs.`date +"%m%d-%H%M"`"
PMEM_PATH=/mnt/pmem/
SAMPLE_TIME=15                                  # default, -t argument to MLC
socket=0

function init_outputs() {
   rm -rf $OUTPUT_PATH 2> /dev/null
   mkdir $OUTPUT_PATH

   DELAYS_FILE=$OUTPUT_PATH/delays.txt
   for DELAY in "${DELAYS[@]}"; do 
      echo $DELAY >> $DELAYS_FILE
   done
   DRAM_PERTHREAD=$OUTPUT_PATH/DRAM_perthread.txt
   PMem_PERTHREAD=$OUTPUT_PATH/PMem_perthread.txt
}

#################################################################################################
# Main
#################################################################################################

# Add the current working directory to $PATH
pushd $PWD &> /dev/null
init_outputs
#check_cpus
#get_cpu_range_per_socket
#verify_hyperthreading
#validate_config