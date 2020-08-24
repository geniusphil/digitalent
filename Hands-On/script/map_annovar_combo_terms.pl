#!/usr/bin/perl
use strict;
use warnings;

# Map combination terms from ANNOVAR

my $file = shift;
open (my $fh, '<', $file) or die "Can't open $file:$!\n";

my %combo_terms = (
  'downstream_gene_variant;upstream_gene_variant' => 'intergenic_1kb_variant', 
  'upstream_gene_variant;downstream_gene_variant' => 'intergenic_1kb_variant', 
  '5_prime_UTR_variant;3_prime_UTR_variant'       => 'gene_variant',
  '3_prime_UTR_variant;5_prime_UTR_variant'       => 'gene_variant',
  'exonic;splice_region_variant'                  => 'exonic_splice_region_variant',
  );

while (my $line = <$fh>) {
  chomp $line;
  if ($line =~ '^Position') {
    print "$line\n";
    next;
  }
  my ($pos, $ID, $ann) = split(/\t/, $line);
  if (exists $combo_terms{$ann}) {
    $ann = $combo_terms{$ann};
  }
  #$ann = join(';',@new_annos);
  print "$pos\t$ID\t$ann\n";
}
close $fh;
