#!/usr/bin/perl
use strict;
use warnings;

# Formats ANNOVAR variants from .annovar_multianno.txt that
# are not formatted like the rest of the lines in the file.
# Works with inconsistent_lines.txt 
my $file = shift;
open(my $fh, '<', $file) or die "Can't open $file:$!\n";

while (<$fh>) {
  chomp $_;
  next if $_ =~ '^Chr';
  my ($chr, $start, $end, $ref, $alt, $ann, $gene, $gene_detail,
      $exonic_ann, $aa, $vcf_file_cols) = split(/\t/, $_);
  my $pos = $chr.':'.$start.':'.$end;
  my @details = split(';', $gene_detail);
  my @trxs;
  my $trxs;
  foreach (@details) {
    my @gene_details = split(',', $_);
    foreach (@gene_details) {
      my @id_details = split(':', $_);
      push(@trxs, $id_details[0]); 
    }
  }
  if (scalar @trxs > 1) {
    $trxs = join(';', @trxs);
  }
  else {
    $trxs = "@trxs";
  }
  print "$pos\t$trxs\t$ann\n";
}
close $fh;
