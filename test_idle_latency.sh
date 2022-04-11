MLC=($(command -v mlc))                         # default, -m option to specify location of the mlc binary
#NDCTL=($(command -v ndctl))                     # default, -n option to specify location of the ndctl binary 
#IPMCTL=($(command -v ipmctl))                   # default, -i option to specify the location of the ipmctl binary 
BC=($(command -v bc))				# Path to bc
NUMACTL=($(command -v numactl))			# Path to numactl
LSCPU=($(command -v lscpu))                     # Path to lscpu
AWK=($(command -v awk))                         # Path to awk
GREP=($(command -v grep))			# Path to grep
EGREP=($(command -v egrep))			# Path to egrep
SED=($(command -v sed))	
OUTPUT_PATH="./mlc-outputs.`date +"%m%d-%H%M"`"
PMEM_PATH=/mnt/pmem/

function get_first_cpu_in_socket() {
   NUMA_CPUS=$( ${NUMACTL} --hardware | ${GREP} "node ${socket} cpus" | cut -f2 -d ":" )
   if [ -z "${NUMA_CPUS}" ]; then
     echo "ERROR: get_first_cpu_in_socket: Could not identify cpus for numa node ${socket}. Exiting"
     exit 1
   fi
   TOK=( ${NUMA_CPUS} )
   FIRST_CPU_ON_SOCKET=${TOK[0]}
}

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

function idle_latency() {
   get_first_cpu_in_socket

   echo ""
   echo --- Idle Latency Tests ---
   echo "Using CPU ${FIRST_CPU_ON_SOCKET}"
   echo -n "PMem idle sequential latency: "
   $MLC --idle_latency -c${FIRST_CPU_ON_SOCKET} -J$PMEM_PATH > $OUTPUT_PATH/idle_seq.txt
   ${GREP} "Each iteration took" $OUTPUT_PATH/idle_seq.txt

   echo -n "PMem idle random latency: "
   $MLC --idle_latency -c${FIRST_CPU_ON_SOCKET} -l256 -J$PMEM_PATH > $OUTPUT_PATH/idle_rnd.txt
   ${GREP} "Each iteration took" $OUTPUT_PATH/idle_rnd.txt
   echo "--- End ---"
}

#################################################################################################
# Main
#################################################################################################

# Add the current working directory to $PATH
pushd $PWD &> /dev/null
init_outputs
get_first_cpu_in_socket
idle_latency