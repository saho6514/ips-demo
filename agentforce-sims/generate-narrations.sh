#!/bin/bash
# Run from the agentforce-sims/ directory.
# Generates narration mp3s for all 6 sims via ElevenLabs.

API_KEY="43f4c2e5c1325adb68a8748c9857ac86f1bad13d9e1755dcff44747fbe19ff58"
VOICE_ID="ZSNL4hPqCnqoMPaI4jGX"
MODEL="eleven_multilingual_v2"
DIR="$(cd "$(dirname "$0")" && pwd)"

generate() {
  local name="$1"
  local text="$2"
  local out="$DIR/${name}-narration.mp3"
  echo "Generating ${name}..."
  curl -s -X POST "https://api.elevenlabs.io/v1/text-to-speech/${VOICE_ID}" \
    -H "xi-api-key: ${API_KEY}" \
    -H "Content-Type: application/json" \
    -d "{\"text\":$(echo "$text" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))'),\"model_id\":\"${MODEL}\",\"voice_settings\":{\"stability\":0.5,\"similarity_boost\":0.75}}" \
    --output "$out"
  echo "  → saved to ${out}"
}

generate "scopely" "Scopely's biggest revenue risk is lapsed players — and the window to re-engage them closes fast. What you're about to see is what it looks like when a VP of Monetization goes straight to Slack, asks Agentforce to draft a re-engagement campaign, and watches it go from brief to forty-seven thousand personalized deployments in under three minutes. No one opens Marketing Cloud. No analyst builds a segment. One conversation in Slack, one judgment call on the offer, and it's live. This is what headless marketing looks like when your tools work where your team already works."

generate "mobileone" "For MobileOne, iPhone launch day is make-or-break — and stock gaps don't announce themselves until customers are already walking out. Commerce Cloud OMS runs headlessly, monitoring live inventory across every distribution center around the clock. When three San Diego stores came up ninety-one units short before nine AM, Store Pulse had the gap flagged, the routing plan staged, and the decision in Marcus's Slack before a single customer was turned away. One reply. Ninety-one units rerouted. The order shipped complete. That's the headless advantage."

generate "turntide" "Turntide's competitive edge is the intelligence inside their motors — real-time performance data that tells the story of every installation. The problem is that data usually lives in an ops dashboard no one in sales ever opens. Marketing Cloud Next changes that. Agentforce runs headlessly against motor telemetry, spots the accounts whose hardware is quietly degrading, and surfaces a proactive service and renewal conversation in Slack — before the customer picks up the phone to complain. The data was always there. Now it drives action automatically."

generate "niantic" "Niantic's enterprise pipeline was invisible — not because the accounts weren't there, but because no one had connected Scaniverse usage data to CRM. Marketing Cloud Next runs headlessly against product telemetry around the clock. When Pipeline Scout found three hundred forty enterprise accounts actively using Scaniverse with zero sales contact, it didn't wait for a QBR — it staged personalized outreach for two hundred ninety-seven accounts automatically and flagged the defense accounts for specialist routing. Derek reviewed once, replied once. Two-point-one million dollars of pipeline activated."

generate "bright" "In professional services, the gap between scope and billing is where revenue disappears. Revenue Cloud runs headlessly across every active project — reconciling change orders, tracing origins, flagging unbilled work before the billing window closes. When Margin Watch surfaced forty-six thousand dollars of scope creep at day sixty-three, Rachel already had the contract analysis. She spent ninety seconds deciding which charge to absorb as a goodwill gesture. The machine caught it. The human decided what to do with it. Forty-one thousand dollars recovered."

generate "ips" "For IPS, Ferguson isn't just a customer — they're a benchmark account. A backorder notice on a three-hundred-thousand-dollar stocking order is how you lose Q4 positioning. Commerce Cloud OMS monitors every distributor order in real time, cross-checking inventory across all distribution centers automatically. When Channel Watch flagged four unfulfillable SKUs on the Ferguson order, a complete three-DC routing plan was already staged. Sarah approved in ninety seconds. Ferguson got a complete order. The relationship held. That's what headless order management looks like."

echo ""
echo "Done. All 6 narration files generated."
