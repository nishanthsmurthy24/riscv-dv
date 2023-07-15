list=("250" "500" "750" "1000" "1500" "2000" "2500" "3000" "4000" "5000" "6000" "7500" "10000" "12500" "15000" "17500" "20000")

for i in "${!list[@]}";
do 
    current=${list[$i]}
    next=${list[$((i+1))]}
    python3 run.py --test riscv_rand_instr_test --seed 1 --output runs/rand_dir_${list[$i]}
    python3 cov.py --dir runs/rand_dir_${list[$i]}/spike_sim --enable_visualization -o runs/rand_dir_${list[$i]}/cov
    date >> runs/instruction_count.log
    ${list[$i]} >> runs/instruction_count.log
    echo ${list[$i]} >> runs/instruction_count.log
    wc -l runs/rand_dir_${list[$i]}/spike_sim/riscv_rand_instr_test_0.csv >> runs/instruction_count.log
    echo " " >> runs/instruction_count.log
    
    sed -i "s/+instr_cnt=$current/+instr_cnt=$next/g" yaml/base_testlist.yaml
done

sed -i 's/+instr_cnt=/+instr_cnt=250/g' yaml/base_testlist.yaml

