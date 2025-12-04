cpmaddpackage("gh:ZIMO-Elektronik/MDU@0.19.0")
add_include_what_you_must_target(
  MDUIncludeWhatYouMust TARGET MDU::MDU EXCLUDE_HEADERS "rmt_mdu_encoder.h"
  "command_station.hpp")

cpmaddpackage("gh:ZIMO-Elektronik/ULF_COM@0.1.1")
add_include_what_you_must_target(ULF_COMIncludeWhatYouMust TARGET ULF::COM)

cpmaddpackage("gh:ZIMO-Elektronik/ZSU@0.1.1")
add_include_what_you_must_target(ZSUIncludeWhatYouMust TARGET ZSU::ZSU)
