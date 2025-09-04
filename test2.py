import re
from fpdf import FPDF

class PDF(FPDF):
    def header(self):
        # Title in header
        self.set_font("Arial", 'B', 14)  # ✅ Use built-in Arial
        self.cell(0, 10, "BlockCred-Sui: Waitlist Strategy Guide", ln=True, align="C")
        self.ln(5)

    def footer(self):
        # Page footer with page number
        self.set_y(-15)
        self.set_font("Arial", 'I', 8)  # ✅ Built-in Arial italic
        self.cell(0, 10, f"Page {self.page_no()}", align="C")

# Define content
content = """
🧭 1. Define Your Ideal Customer Profile (ICP)

Who would need credential management (on-chain or off-chain)?

🎓 Education & Certification
- Universities / Colleges: Issue verifiable degrees/diplomas on-chain
- Online Learning Platforms (e.g. Coursera, edX): Credentialing teams

👷‍♂️ Professional Licensing & Certification
- Certifying bodies (e.g., PMI, CFA): Issue, revoke, verify licenses
- Trade Unions & Guilds: Medical, Legal, Engineering councils

🧑‍💻 Employers & Hiring Platforms
- Tech Companies / HR Depts: Verify candidate credentials
- HR SaaS (Workday, Greenhouse): Integrate verifiable credentials

🏛️ Government & Public Sector
- Ministries of Education / Labor: Digitize national records
- Immigration Authorities: Verify academic/work credentials

🏦 Financial Institutions
- KYC/AML Automation: Credential-based identity verification

🎯 2. How to Reach & Attract Them (Waitlist Strategy)

A. Segmented Landing Pages
- Custom pages: /for-universities, /for-certification-bodies, etc.
- Highlight pain points + benefits + “Join Waitlist” CTA

B. Inbound Content Strategy
- Blog ideas: On-chain credentials, degree fraud, hiring trust
- CTAs to waitlist on every post

C. Outbound Prospecting
- Platforms: LinkedIn, Crunchbase, AngelList
- Outreach Message:
  “Hi [Name], I’m building BlockCred-Sui — a verifiable credential platform on Sui. We’re opening early access for organizations like [Company Name] to issue, manage, and verify credentials securely. Would you be open to trying it out or giving quick feedback?”

D. Web3 & Edu/HR Conferences
- Target: EdTech Week, HR Tech Conference, Web3 Summit, ETHGlobal

E. Partnerships / Pilots
- Offer free pilot programs to:
  - 3–5 universities or certifying bodies
  - HR teams of remote-first startups

🔑 3. Waitlist Incentives (To Maximize Conversions)
- Early Access / Beta Tester badge
- Free usage for X months
- Priority onboarding/support
- Co-marketing (e.g. "Trusted by X University")

🔄 4. Suggested Tech Stack for Waitlist
- Frontend: Next.js / React
- Forms: Typeform, Tally, native React forms
- Backend: Supabase / Firebase
- Email Automations: Mailchimp / ConvertKit
- UI: Add viral mechanics (referrals, priority queue)

🎁 Bonus: Sample Waitlist Hook
BlockCred-Sui
Verifiable Credentials. Decentralized. Trusted.
Join 200+ institutions and hiring teams rethinking how we issue and verify credentials.
[Join Waitlist →]
"""

# Remove emojis (anything outside BMP range)
def remove_emojis(text):
    return re.sub(r'[^\x00-\x7F]+', '', text)

content = remove_emojis(content)

# Create PDF
pdf = PDF()
pdf.set_auto_page_break(auto=True, margin=15)
pdf.add_page()
pdf.set_font("Arial", '', 12)  # ✅ Default font
pdf.multi_cell(0, 10, content)

# Save PDF
pdf.output("BlockCred-Sui_Waitlist_Strategy_Guide.pdf")
