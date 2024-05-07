type Footer = {
  serverId: number;
  playerCount: number;
  maxPlayers: number;
};

type Player = {
  name: string;
  id: number;
};

type SheetData = {
  footer: Footer;
  players: Player[];
};

export type { SheetData as default };
