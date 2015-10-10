# Inputs from the top level
a:

# Arguments for the derivation builder
{ name  # The name injected into the path of the ouput
, builder  # The binary used to perform the build
, args ? null # Arguments when the build binary is called
, targetInputs ? null
, builderInputs ? null
, targetArch ? null
}:

# derivationStrict
  # args, builder, outputHash, outputHashAlgo, outputHashMode, outputs

derivation {
  #inherit name;
  #builder = ./builder.sh;
  #system = if targetArch != null then targetArch else a.properties.targetArch;
}
