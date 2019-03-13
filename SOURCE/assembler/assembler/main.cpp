#include<bits/stdc++.h>
using namespace std;

int Dec_2_Bin(int n)
{
	int x;
	string Bin = "";
	string s;
	while (n > 0)
	{
		x = n % 2;
        stringstream ss;
        ss << x;
        string s = ss.str();
		Bin = s + Bin;
		n /= 2;
	}
	x = atoi(Bin.c_str());
	return x;
}

int Reg_Num(string s)
{
	if (!(s.compare("$zero") || !(s.compare("$0"))))	return Dec_2_Bin(0);
	else if (!(s.compare("$at")))						return Dec_2_Bin(1);
	else if (!(s.compare("$v0")))						return Dec_2_Bin(2);
	else if (!(s.compare("$v1")))						return Dec_2_Bin(3);
	else if (!(s.compare("$a0")))						return Dec_2_Bin(4);
	else if (!(s.compare("$a1")))						return Dec_2_Bin(5);
	else if (!(s.compare("$a2")))						return Dec_2_Bin(6);
	else if (!(s.compare("$a3")))						return Dec_2_Bin(7);
	else if (!(s.compare("$t0")))						return Dec_2_Bin(8);
	else if (!(s.compare("$t1")))						return Dec_2_Bin(9);
	else if (!(s.compare("$t2")))						return Dec_2_Bin(10);
	else if (!(s.compare("$t3")))						return Dec_2_Bin(11);
	else if (!(s.compare("$t4")))						return Dec_2_Bin(12);
	else if (!(s.compare("$t5")))						return Dec_2_Bin(13);
	else if (!(s.compare("$t6")))						return Dec_2_Bin(14);
	else if (!(s.compare("$t7")))						return Dec_2_Bin(15);
	else if (!(s.compare("$s0")))						return Dec_2_Bin(16);
	else if (!(s.compare("$s1")))						return Dec_2_Bin(17);
	else if (!(s.compare("$s2")))						return Dec_2_Bin(18);
	else if (!(s.compare("$s3")))						return Dec_2_Bin(19);
	else if (!(s.compare("$s4")))						return Dec_2_Bin(20);
	else if (!(s.compare("$s5")))						return Dec_2_Bin(21);
	else if (!(s.compare("$s6")))						return Dec_2_Bin(22);
	else if (!(s.compare("$s7")))						return Dec_2_Bin(23);
	else if (!(s.compare("$t8")))						return Dec_2_Bin(24);
	else if (!(s.compare("$t9")))						return Dec_2_Bin(25);
	else if (!(s.compare("$k0")))						return Dec_2_Bin(26);
	else if (!(s.compare("$k1")))						return Dec_2_Bin(27);
	else if (!(s.compare("$gp")))						return Dec_2_Bin(28);
	else if (!(s.compare("$sp")))						return Dec_2_Bin(29);
	else if (!(s.compare("$fp")))						return Dec_2_Bin(30);
	else if (!(s.compare("$ra")))						return Dec_2_Bin(31);
}

string Reg_Num_Final(string a)
{
	int n;
	int x=Reg_Num(a);
    stringstream ss;
    ss << x;
    string s = ss.str();
	n = s.length();
	while (n < 5)
	{
		s = "0" + s;
		n = s.length();
	}
	return s;
}

string Funct_Binary(int a)
{
	int n;
    int x=Dec_2_Bin(a);
    stringstream ss;
    ss << x;
    string s = ss.str();
	n = s.length();
	while (n < 6)
	{
		s = "0" + s;
		n = s.length();
	}
	return s;
}

string Reg_Binary(int a)
{
	int n;
	int x= Dec_2_Bin(a);
    stringstream ss;
    ss << x;
    string s = ss.str();
	//std::string s = std::to_string(Dec_2_Bin(a));
	n = s.length();
	while (n < 5)
	{
		s = "0" + s;
		n = s.length();
	}
	return s;
}

string Str_2_Bin(string a)
{
	int n;
	int b = atoi(a.c_str());
//	std::string s = std::to_string(Dec_2_Bin(b));
    int x = Dec_2_Bin(b);
    stringstream ss;
    ss << x;
    string s = ss.str();
	n = s.length();
	while (n < 5)
	{
		s = "0" + s;
		n = s.length();
	}
	return s;
}

string Str_2_Bin_1(string a)
{
	int n;
	int b = atoi(a.c_str());
	//std::string s = std::to_string(Dec_2_Bin(b));
	int x = Dec_2_Bin(b);
    stringstream ss;
    ss << x;
    string s = ss.str();
	n = s.length();
	while (n < 16)
	{
		s = "0" + s;
		n = s.length();
	}
	return s;
}

string Str_2_Bin_2(string a)
{
	int n;
	int b = atoi(a.c_str());
	//std::string s = std::to_string(Dec_2_Bin(b));
	int x = Dec_2_Bin(b);
    stringstream ss;
    ss << x;
    string s = ss.str();
	n = s.length();
	while (n < 26)
	{
		s = "0" + s;
		n = s.length();
	}
	return s;
}

int main()
{
	system("color F1");
	ofstream myfile;
	myfile.open("Binary.txt");
	string x, op, b1, b2, b3, b4, Binary, op1, rs, rt, rd, shamt, funct, Immediate = "";
	cout << "Enter the Assembly Code: " << endl;

	while(1)
	{
		op = "";
		b1 = "";
		b2 = "";
		b3 = "";
		b4 = "";
		Binary = "";
		op1 = "";
		rs = "";
		rt = "";
		rd = "";
		shamt = "";
		funct = "";
		Immediate = "";
	getline(cin, x);
	if (!(x.compare("end")))
	{
		//system("vlib work vlog pipelined_mips_in_verilog.v & vsim -gui work.PIPELINE_MIPS");
		break;
	}
	int i, n = 0;
	n = x.length();

	for (i = 0; (x[i] != ' '); i++)											op = op + x[i];
	for (i = i + 1; (i < n && (x[i] != ',')); i++)							b1 = b1 + x[i];
	for (i = i + 1; (i < n && ((x[i] != ',') && (x[i] != '('))); i++)		b2 = b2 + x[i];
	for (i = i + 1; ((i < n) && (x[i] != ')')); i++)						b3 = b3 + x[i];

	if (!(op.compare("add")) || !(op.compare("and")) || !(op.compare("or")) || !(op.compare("slt")))
	{
		op1 = Funct_Binary(0);
		rs = Reg_Num_Final(b2);
		rt = Reg_Num_Final(b3);
		rd = Reg_Num_Final(b1);
		shamt = Reg_Binary(0);
		if (!(op.compare("add")))		funct = Funct_Binary(32);
		else if (!(op.compare("and")))	funct = Funct_Binary(36);
		else if (!(op.compare("or")))	funct = Funct_Binary(37);
		else if (!(op.compare("slt")))	funct = Funct_Binary(42);
		Binary = op1 + rs + rt + rd + shamt + funct;
	}
	else if (!(op.compare("sll")))
	{
		op1 = Funct_Binary(1);
		funct = Funct_Binary(0);
		rs = Reg_Num_Final(b2);
		rt = Reg_Binary(0);
		rd = Reg_Num_Final(b1);
		shamt = Str_2_Bin(b3);
		Binary = op1 + rs + rt + rd + shamt + funct;
	}
	else if (!(op.compare("jr")))
	{
		op1 = Funct_Binary(0);
		funct = Funct_Binary(8);
		rs = Reg_Num_Final(b1);
		rt = Reg_Binary(0);
		rd = Reg_Binary(0);
		shamt = Reg_Binary(0);
		Binary = op1 + rs + rt + rd + shamt + funct;
	}
	else if (!(op.compare("addi")))
	{
		op1 = Funct_Binary(8);
		rs = Reg_Num_Final(b2);
		rt = Reg_Num_Final(b1);
		Immediate = Str_2_Bin_1(b3);
		Binary = op1 + rs + rt + Immediate;
	}
	else if (!(op.compare("addi")) || !(op.compare("ori")))
	{
		rs = Reg_Num_Final(b2);
		rt = Reg_Num_Final(b1);
		Immediate = Str_2_Bin_1(b3);
		if(!(op.compare("addi")))		op1 = Funct_Binary(8);
		else if(!(op.compare("ori")))	op1 = Funct_Binary(13);
		Binary = op1 + rs + rt + Immediate;
	}
	else if (!(op.compare("beq")))
	{
		op1 = Funct_Binary(4);
		rs = Reg_Num_Final(b1);
		rt = Reg_Num_Final(b2);
		int b = atoi(b3.c_str());
		b = b / 4;
		//std::string b3 = std::to_string(b);

        stringstream ss;
        ss << b;
        string b3 = ss.str();

		Immediate = Str_2_Bin_1(b3);
		Binary = op1 + rs + rt + Immediate;
	}
	else if (!(op.compare("sw")) || !(op.compare("lw")))
	{
		if (!(op.compare("sw")))		op1 = Funct_Binary(43);
		else if (!(op.compare("lw")))	op1 = Funct_Binary(35);
		rs = Reg_Num_Final(b3);
		rt = Reg_Num_Final(b1);
		Immediate = Str_2_Bin_1(b2);
		Binary = op1 + rs + rt + Immediate;
	}
	else if (!(op.compare("j")))
	{
		op1 = Funct_Binary(2);
		int b = atoi(b1.c_str());
		b = b / 4;

        stringstream ss;
        ss << b;
        string b1 = ss.str();

		Immediate = Str_2_Bin_2(b1);
		Binary = op1 + Immediate;
	}
	else if (!(op.compare("jal")))
	{
		op1 = Funct_Binary(3);
		int b = atoi(b1.c_str());
		b = b / 4;
		//std::string b1 = std::to_string(b);
		int x = Dec_2_Bin(b);
        stringstream ss;
        ss << b;
        string s = ss.str();

		Immediate = Str_2_Bin_2(b1);
		Binary = op1 + Immediate;
	}
	myfile << Binary << endl;
	}
	myfile.close();
	system("PAUSE");
}
