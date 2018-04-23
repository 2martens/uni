#!/bin/sh
# Modify the following variables to match your configuration.

# The path where ground truth binary masks are
GT_PATH=/home/jim/git-repos/uni/ccv/saliency/binarymasks/
# The path where saliency maps computed by your system are
SAL_PATH=/home/jim/git-repos/uni/ccv/saliency/saliency_maps/
# The location of the saliency evaluation tool
EVAL_TOOL=/home/jim/git-repos/uni/ccv/saliency/SaliencyEvaluationTool/SaliencyEvaluationTool.jar
# The path where to write results to
RES_PATH=/home/jim/git-repos/uni/ccv/saliency/results

# This ensures the results directory exists
#mkdir -p "${RES_PATH}"

# Run the evaluation script using paths defined above
java -jar ${EVAL_TOOL} pathGT="${GT_PATH}" pathSM="${SAL_PATH}" pathResult="${RES_PATH}"
