import { Client, GatewayIntentBits, Events } from 'discord.js';
import { exec } from 'child_process';
import dotenv from 'dotenv';
import path from 'path';

dotenv.config({ path: path.join(__dirname, '../../../../.env') });

const client = new Client({
  intents: [
    GatewayIntentBits.Guilds,
    GatewayIntentBits.GuildMessages,
    GatewayIntentBits.MessageContent,
  ],
});

const ALLOWED_USER_ID = process.env.DISCORD_ALLOWED_USER_ID;

client.once(Events.ClientReady, (c) => {
  console.log(`[ORACLE] Ready! Logged in as ${c.user.tag}`);
});

client.on(Events.MessageCreate, async (message) => {
  if (message.author.bot) return;
  if (ALLOWED_USER_ID && message.author.id !== ALLOWED_USER_ID) return;

  const content = message.content.toLowerCase();

  if (content === '!status') {
    exec('systemctl --user list-timers --no-pager', (error, stdout, stderr) => {
      if (error) {
        message.reply(`Error checking status: ${error.message}`);
        return;
      }
      message.reply(`**Agent Timers:**\n\`\`\`\n${stdout}\n\`\`\``);
    });
  }

  if (content === '!hf') {
    exec('bash scripts/utils/hf-helper.sh check', (error, stdout, stderr) => {
      const response = stdout || stderr || 'Hugging Face check failed.';
      message.reply(`**Hugging Face Status:**\n\`\`\`\n${response}\n\`\`\``);
    });
  }

  if (content.startsWith('!ask ')) {
    const question = message.content.slice(5);
    message.reply(`[ASSISTANT] I received your question: "${question}". Currently, I am in "Local Agent Mode". I can help you manage your development environment. Try !status or !run.`);
  }

  if (content.startsWith('!run ')) {
    const cmd = message.content.slice(5);
    // Safety check: Only allow specific scripts/commands
    const safeCommands = ['docker ps', 'git status', 'npm run lint'];
    const isSafe = safeCommands.some(s => cmd.startsWith(s)) || cmd.startsWith('bash scripts/');

    if (!isSafe) {
      message.reply('Unauthorized or unsafe command blocked.');
      return;
    }

    exec(cmd, (error, stdout, stderr) => {
      const response = stdout || stderr || 'Command executed (no output).';
      message.reply(`**Output:**\n\`\`\`\n${response.slice(0, 1900)}\n\`\`\``);
    });
  }
});

if (process.env.DISCORD_TOKEN) {
  client.login(process.env.DISCORD_TOKEN);
} else {
  console.error('[ORACLE] DISCORD_TOKEN is missing in .env');
}
