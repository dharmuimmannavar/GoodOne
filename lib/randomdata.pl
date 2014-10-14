#!/usr/bin/perl -w

#
# randomdata.pl

use strict;
use MyApp::Schema;
use Data::Dumper;

my $val=0;

my $schema=MyApp::Schema->connect("dbi:Pg:database=business","skanda","skanda");
my $author_model=$schema->resultset('Employee');
my %Details;
while($val != 50000)
{
	my $var=int(rand(1000000));
	$var = 'Emp'.$var;
	if(exists $Details{$var})
	{
	}
	else
	{
		push(@{$Details{$var}},$var);
		$val++;
	}
}

$val=0;
my %temp;
my @mobile;
while($val != 50000)
{
	my $var=int(rand(10000000000));
	if(exists $temp{$var})
	{
	}
	else
	{
		if($var > 9000000000)
		{
			push(@mobile,$var);
			$val++;
		}
	}
}

my %temp1;
my (@name,@email);
my @arr=qw/A B C D E F G H I J K L M N O P Q R S T U V W X Y Z/;
$val=0;
my $name="";
while($val != 50000)
{
	my $var=int(rand(26));
	$name .= $arr[$var - 1];
	if(length($name) == 8)
	{

		if(exists $temp1{$var})
		{
		}
		else
		{
			push (@name,$name);
			push(@email,"$name\@demo.com");
			$name="";
			$val++;
		}
	}
}

$val=0;
my @doj;
while($val != 50000)
{
	my $day=int(rand(28));
	my $month=int(rand(11));
	my $year=int(rand(10000));
	if($year > 2000 and $year < 2014)
	{
		my $date=$year."/".($month+1)."/".($day+1);
		push(@doj,$date);
		$val++;
	}
}


$val=0;
my @sal;
while($val != 50000)
{
	my $salary=int(rand(100000));
	if($salary > 10000)
	{
		push(@sal,$salary);
		$val++;
	}
}

my $incrementor=-1;
foreach my $temp_var(keys %Details)
{
	$incrementor++;
	push(@{$Details{$temp_var}},$name[$incrementor],$email[$incrementor],$mobile[$incrementor],$doj[$incrementor],$sal[$incrementor]);
}


foreach my $temp_var(keys %Details)
{
	$schema->populate('Employee',[
				[qw/e_id e_name e_email/],[$temp_var,$Details{$temp_var}->[1],$Details{$temp_var}->[2]]
					]
				);
	
	$schema->populate('EmployeeAdditional',[
				[qw/e_id e_mobile e_doj e_salary/],[$temp_var,$Details{$temp_var}->[3],$Details{$temp_var}->[4],$Details{$temp_var}->[5]]
					]
				);
}
print "Succesfully loaded\n";
1;
