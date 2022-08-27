import { Stack, Text } from "@chakra-ui/react";

interface Props {
  left: string;
  right: string;
}

const styledText = {
  fontWeight: "bold",
  fontSize: "xs", // sm
  color: "gray.400",
  lineHeight: 4,
  textTransform: "uppercase",
  letterSpacing: "wider",
};

const SectionHeader: React.FC<Props> = (props: Props) => {
  return (
    <Stack direction="row" justifyContent="space-between" pl={2} pr={2} pb={1}>
      <Text sx={styledText}>{props.left}</Text>
      <Text sx={styledText}>{props.right}</Text>
    </Stack>
  );
};

export default SectionHeader;
