#!/bin/bash
FRUITS=("apple" "banana" "orange")
echo "The first fruit is: ${FRUITS[0]}"
echo "The second fruit is: ${FRUITS[1]}"
echo "The third fruit is: ${FRUITS[2]}"
echo "The number of fruit are: ${FRUITS[@]}"
echo "Total number of fruit are: ${FRUITS[#]}"

