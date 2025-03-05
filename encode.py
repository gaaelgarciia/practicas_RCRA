import sys

def read_dom_file(input_file):
    with open(input_file, "r") as f:
        lines = [line.strip() for line in f.readlines()]
    return lines

def write_lp_file(output_file, facts):
    with open(output_file, "w") as f:
        for fact in facts:
            f.write(fact + "\n")

def generate_facts(lines):
    facts = []
    facts.append(f"#const n = {len(lines)}.\n")  

    for row, line in enumerate(lines):
        for col, char in enumerate(line):
            if char == "0":
                facts.append(f"_drawcircle({row},{col}, white).")
            elif char == "1":
                facts.append(f"_drawcircle({row},{col}, black).")

    
    return facts

def main():
    if len(sys.argv) != 3:
        print("Usage: python3 encode.py input.txt output.lp")
        sys.exit(1)
    
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    
    lines = read_dom_file(input_file)
    facts = generate_facts(lines)
    write_lp_file(output_file, facts)
    
if __name__ == "__main__":
    main()
