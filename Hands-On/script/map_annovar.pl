#!/usr/bin/perl
use strict;
use warnings;

# This script maps ANNOVAR terms to SO.

my %SO_terms = (
    'frameshift insertion' => 'frameshift_elongation',
    'frameshift deletion' => 'frameshift_truncation',
    'frameshift block substitution' => 'frameshift_variant',
    'frameshift substitution' => 'frameshift_variant',
    'stopgain' => 'stop_gained',
    'stoploss' => 'stop_lost',
    'nonframeshift insertion' => 'inframe_insertion',
    'nonframeshift deletion' => 'inframe_deletion',
    'nonframeshift block substitution' => 'inframe_variant',
    'nonframeshift substitution' => 'inframe_variant',
    'nonsynonymous SNV' => 'missense_variant',
    'synonymous SNV' => 'synonymous_variant',
    'unknown' => 'sequence_variant',
    'exonic'     => 'exon_variant',
    'splicing'   => 'splice_region_variant',
    'ncRNA'      => 'non_coding_transcript_variant',
    'UTR5'       => '5_prime_UTR_variant',
    'UTR3'       => '3_prime_UTR_variant',
    'intronic'   => 'intron_variant',
    'upstream'   => 'upstream_gene_variant',
    'downstream' => 'downstream_gene_variant',
    'intergenic' => 'intergenic_variant',
    'ncRNA_intronic' => 'non_coding_transcript_intron_variant',
    'ncRNA_exonic' => 'non_coding_transcript_exon_variant',
    'ncRNA_UTR3' => 'incomplete_transcript_3UTR_variant',
    'ncRNA_UTR5' => 'incomplete_transcript_5UTR_variant',
    'ncRNA_splicing'   => 'non_coding_transcript_splice_region_variant',
    'upstream;downstream' => 'intergenic_1kb_variant',
    'exonic;splicing' => 'exonic_splice_region_variant',
    'UTR5;UTR3' => 'gene_variant',
    'ncRNA_UTR5;ncRNA_UTR3' => 'gene_variant',
    );

=cut

my %combo_terms = ( 
  'downstream_gene_variant;upstream_gene_variant' => 'intergenic_1kb_variant',
  '5_prime_UTR_variant;3_prime_UTR_variant' => 'gene_variant',
  'exonic;splice_region_variant' => 'exonic_splice_region_variant',
  );

my %SO_terms = (
    'frameshift insertion' => 'frameshift_elongation',
    'frameshift deletion' => 'frameshift_truncation',
    'frameshift substitution' => 'frameshift_variant',
    'nonframeshift insertion' => 'inframe_insertion',
    'nonframeshift deletion' => 'inframe_deletion',
    'nonsynonymous SNV' => 'missense_variant',
    'synonymous SNV' => 'synonymous_variant',
    'stopgain' => 'stop_gained',
    'stoploss' => 'stop_lost',
    );

=cut

print "Position\tANNOVAR_Transcript_ID\tANNOVAR\n";
my $file = shift;
open(my $fh, '<', $file) or die "Can't open $file:$!\n";

while (my $line = <$fh>) {
  chomp $line;
  if ($line =~ "^Position") {
    next;
  }
  my @cols = split('\t', $line);
  if ($cols[2] eq '.') {
    print "$line\n";
  }
  else {
    my @mapped_effects;
    my @effect = split(';', $cols[2]);
    foreach (@effect) {
      if (exists $SO_terms{$_}) {
        $_ = $SO_terms{$_};
        push (@mapped_effects, $_);
      }
      else {
        push (@mapped_effects, $_);
      }
    }
    my $mapped_terms = join(';', @mapped_effects);
    print "$cols[0]\t$cols[1]\t$mapped_terms\n";
  }
}
close $fh;
