### Annovar ###
use Getopt::Std;

sub Usage{
    print STDERR <<EOF;
    Usage: annovar.pl -i <sample name>  -r <reference version> -o <annotation output>

    Command:
             -i	 sample file convert to annovar format (Example: *.avinput)
             -r  reference version (hg19 / hg38)
             -o	 sample file annotation output

EOF
    exit;
}
my %opt;
getopt("i:r:o:", \%opt);
my $input = $opt{i} or &Usage();
my $rf = $opt{r} or &Usage();
my $output = $opt{o} or &Usage();
my $PATH = '/pkg/biology/ANNOVAR/ANNOVAR_20200608/';
my $DB_PATH = '/work1/ACD109058/humandb/';
my $SYS_DB_HG19_PATH = '/pkg/biology/reference/Homo_sapiens/annovar/hg19';
my $SYS_DB_HG38_PATH = '/pkg/biology/reference/Homo_sapiens/annovar/hg38';


`$PATH/table_annovar.pl --thread 3 $input $DB_PATH -buildver $rf -out $output -remove -protocol refGene,ensGene,cytoBand,genomicSuperDups,gwasCatalog,avsnp150,esp6500siv2_all,1000g2015aug_all,1000g2015aug_afr,1000g2015aug_amr,1000g2015aug_eur,1000g2015aug_eas,1000g2015aug_sas,nci60,cosmic85_coding,clinvar_20180603,gnomad_genome,exac03,intervar_20180118,dbnsfp31a_interpro -operation g,g,r,r,r,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f -otherinfo -nastring NA`;

print STDERR "Finished\n";
