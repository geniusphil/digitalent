#!/usr/bin/perl
use strict;
use warnings;

# This script takes the ANNOVAR .annovar_multianno.txt output 
# from table_annovar.pl and pulls out chr, start, end, transcript ID 
# and variant effects for each line
# TODO: Deal with inconsistencies in transcript ID storage and comma/semi-colon separation
# 	These are due to multiple genes in Gene.refGene column
#	Multiple transcripts for all genes separated by ; and multiple transcripts for each 
#	gene separated by ,
my $file = shift;
open (FH, '<', $file) or die "Can't open $file:$!\n";

print "Position\tTranscript_ID\tANNOVAR\n";

while (my $line = <FH>) {
  chomp $line;
  next if $line =~ '^Chr';
  my ($chr, $start, $end, $ref, $alt, $ann, $gene, $gene_detail, 
      $exonic_ann, $aa, $vcf_file_cols) = split(/\t/, $line);
  my $pos = $chr.':'.$start.':'.$end;

=cut

These are column 9 and 10 with the transcript ID on column 11:

synonymous SNV
nonsynonymous SNV
frameshift deletion
nonframeshift deletion
nonframeshift insertion
frameshift insertion
frameshift substitution
nonframeshift substitution

unknown UNKNOWN
col 9: $exonic_ann = unknown
col 10: $aa = UNKNOWN

The rest of the annotations are on column 9 with the transcript ID on 
column 10

=cut

  if (($ann eq "exonic") & ($exonic_ann ne "unknown")) {
    $ann = "exon_variant";
    if ($aa !~ ':') {
      # I think this fixes some lines where there is one less column
      # which throws off the split
      # Not sure when this happens and why I put this in????
      $exonic_ann = $exonic_ann." ".$aa;
      # This moves the string with the transcript ID into the 
      # correct column.
      $aa = $vcf_file_cols;
    }
    my $complete_ann = $ann.';'.$exonic_ann;
    my @all_aa = split(',',$aa);
    my $trxs;
    my @trxs;
    foreach (@all_aa) {
      my ($gene, $transcript, $exon, $hgvs_c, $hgvs_p) = split(':', $_);
      push(@trxs, $transcript);
    }
    if (scalar @trxs > 1) {
      $trxs = join(';', @trxs);
    }
    else {
      $trxs = "@trxs";
    }
    print "$pos\t$trxs\t$complete_ann\n";  
  }
  elsif (($exonic_ann eq "unknown") & ($ann eq "exonic")) {
    # Handle unknown exonic annotations
    # Mapped unknown to sequence_variant for counting annotation purposes
    # but the sequence_variant doesn't add any information to this annotation
    $ann = "exon_variant";
    $exonic_ann = "sequence_variant";
    print "$pos\t.\t$ann;$exonic_ann\n";
  }

  elsif (($ann eq "exonic;splicing") || ($ann eq "ncRNA_exonic;splicing") || ($ann eq "ncRNA_splicing") || ($ann eq "splicing")) {
    if ($ann eq "exonic;splicing") {
      $ann = "exonic_splice_region_variant";
    }
      my $trxs;
      my @trxs;
    if ($aa =~ /,/) {
      my @all_aa = split(',',$aa);
      foreach (@all_aa) {
        my ($gene, $transcript, $exon, $hgvs_c, $hgvs_p) = split(':', $_);
        push(@trxs, $transcript);
      }
    }
    my @all_gene_detail = split(',', $gene_detail);
    foreach (@all_gene_detail) {
      my @details = split(':', $_);
      push(@trxs, $details[0]);
    }
    if (scalar @trxs > 1) {
      $trxs = join(';', @trxs);
    }
    else {
      $trxs = "@trxs";
    }
    if ($ann eq "exonic_splice_region_variant") {
      print "$pos\t$trxs\t$ann;$exonic_ann\n";  
    }
    if (($ann eq "ncRNA_exonic;splicing") || ($ann eq "ncRNA_splicing") || ($ann eq "splicing")) {
      print "$pos\t$trxs\t$ann\n";
    }
  }

  else {
      print "$pos\t$exonic_ann\t$ann\n";
  }

}

close FH;
