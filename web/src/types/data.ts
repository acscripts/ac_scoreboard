type Footer = {
  serverId: number;
  playerCount: number;
  maxPlayers: number;
};

type Group = {
  name?: string;
  count?: number;
};

type Player = {
  name?: string;
  id?: number;
};

type SheetData = {
  footer: Footer;
  groups: Group[];
  players: Player[];
};

export type { SheetData as default };
