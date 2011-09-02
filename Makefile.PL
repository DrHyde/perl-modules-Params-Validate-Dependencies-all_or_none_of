use ExtUtils::MakeMaker;
WriteMakefile(
  NAME         => 'Params::Validate::Dependencies::all_or_none_of',
  VERSION_FROM => 'lib/Params/Validate/Dependencies/all_or_none_of.pm',
  PREREQ_PM    => {
    'Params::Validate::Dependencies' => 1.12,
  },
);
