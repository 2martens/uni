import argparse
import os
import subprocess


def batch():
    """
    Performs a batch call to the saliency system.
    """
    parser = argparse.ArgumentParser(description="Calls the saliency system")
    parser.add_argument("input", metavar="input", type=str, help="The directory of the input images.")
    parser.add_argument("output", metavar="output", type=str, help="The directory of the saliency maps.")
    parser.add_argument("saliency", metavar="saliency", type=str, help="The path to the saliency tool.")
    
    args = parser.parse_args()
    input_dir = os.fsencode(args.input)
    
    for file in os.listdir(input_dir):
        filename = os.fsdecode(file)
        base_filename, ext = os.path.splitext(filename)
        input_filename = os.path.join(args.input, filename)
        output_filename = os.path.join(args.output, base_filename + "_saliency.png")
        subprocess.run([args.saliency, input_filename, output_filename, "0"], stderr=subprocess.PIPE, check=True)
        
    
if __name__ == "__main__":
    batch()
