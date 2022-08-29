import {
  Text,
  Tag,
  TagLeftIcon,
  HStack,
  Tooltip,
  useClipboard,
} from "@chakra-ui/react";
import { FaUserAlt, FaUserFriends } from "react-icons/fa";

interface Props {
  playerCount: number;
  maxPlayers: number;
  serverId: number;
}

const Footer: React.FC<Props> = (props: Props) => {
  const { hasCopied, onCopy } = useClipboard(props.serverId.toString(), 2500);

  return (
    <HStack>
      <Tooltip closeOnClick={false} label="Player count">
        <Tag>
          <TagLeftIcon as={FaUserFriends} boxSize={4} />
          <Text>
            {props.playerCount} / {props.maxPlayers}
          </Text>
        </Tag>
      </Tooltip>
      <Tooltip
        closeOnClick={false}
        label={hasCopied ? "Copied to clipboard!" : "Your server ID"}
      >
        <Tag onClick={onCopy} cursor="pointer">
          <TagLeftIcon as={FaUserAlt} boxSize={3} />
          <Text>{props.serverId}</Text>
        </Tag>
      </Tooltip>
    </HStack>
  );
};

export default Footer;
