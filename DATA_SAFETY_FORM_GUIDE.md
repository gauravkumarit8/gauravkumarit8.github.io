# Play Console Data Safety Form — Answer Key

This exists for one reason: `REQUIREMENTS.md` §10.1 flags mismatches
between the Privacy Policy and the Data Safety form as **the most common
rejection/enforcement trigger** for exactly this kind of app. Both now
come from this one set of facts. If you ever change what the app collects
or which SDK does what, update this file, then re-check the policy and
the actual Play Console form against it — in that order.

**Not legal advice** — this is a best-effort mapping to Google Play's
current public Data Safety documentation as of September 2026, corrected October 31, 2026, based on
the app's actual manifest, dependencies, and code. Play Console's exact
question wording and category list can change; treat this as a drafting
aid to fill the real form faster and more consistently, not a substitute
for reading the live form yourself before submitting.

---

## Does your app collect or share any of the required user data types?

**Yes**, because of the SDKs the app ships (AdMob, Play Billing), NOT because of
the user's own transaction data.

**Corrected 2026-10-31.** An earlier version of this guide declared the user's
own transaction data as "Financial info > Other financial info: collected".
That was wrong. Google's Data safety help defines "collect" as *transmitting
data from your app off a user's device*, and says that user data accessed by
the app and only processed locally on the device does not need to be disclosed.
The transaction data never leaves the phone (no server, Android cloud backup
off), so it is NOT declared. Declaring it made the Play listing say the app
"may collect: Financial info", which contradicts the on-device promise and
frightens exactly the privacy-minded users this app is for. **Remove that
row in Play Console.** The privacy policy still explains in detail that the
data is read and stored on the device.

Everything else in Play Console's list (Messages, Contacts, Location from the
app itself, Photos, Audio, Web browsing, Personal info, Health) is "No data
collected". The app has no analytics SDK and no crash reporter of its own.

### 1. Financial info > "Purchase history" (keep as before)
| Field | Answer |
|---|---|
| Collected? | Yes |
| Shared with third parties? | No |
| Processed ephemerally? | No |
| Optional or required? | Optional, only if the user starts a Pro subscription |
| Purpose(s) | App functionality (managing the subscription) |
| Data handled by | Google Play Billing: the app receives only a subscription status, never card numbers or UPI IDs |

Keep this one. Over-declaring is low risk; under-declaring is the risk. If you
ever want to remove it, first read Google's current guidance on Play Billing
and the Data safety form.

### 2. What the Google Mobile Ads SDK (AdMob) collects: declare these
The earlier version declared only the Advertising ID. Google's own AdMob page
("Google Play's data disclosure requirements", developers.google.com/admob/android/play-data-disclosure)
lists more, and Google says developers are responsible for disclosing what the
SDK collects. As of that page (checked 2026-10-31) the SDK collects:

| Play Console data type | What AdMob collects | Collected | Shared (with Google) | Purposes |
|---|---|---|---|---|
| Location > Approximate location | Device IP address, which may be used to estimate general location | Yes | Yes | Advertising or marketing; Analytics; Fraud prevention, security, and compliance |
| App activity > App interactions | Taps, app launches, video views, ad interactions | Yes | Yes | same |
| App info and performance > Diagnostics | App and SDK performance information (launch time, hang rate, energy use) | Yes | Yes | same |
| Device or other IDs | Android advertising ID, app set ID | Yes | Yes | same |

Answer "optional" for these (Google's page says collection can be limited
through consent and the user's ad-ID controls). Free users only: Pro
subscribers see no ads. **Do not copy this table blindly:** open Google's AdMob
page, check the version it describes against the `play-services-ads` version in
`app/build.gradle` (23.6.0 at the time of writing; that page describes a newer
SDK, so also consider upgrading), and tick what Play Console itself suggests
for your linked AdMob account. If the two differ, follow Google's page.

## Security practices section

| Question | Answer |
|---|---|
| Is data encrypted in transit? | Not applicable for financial data (never transmitted). For the Advertising ID / purchase-status traffic to Google, that goes over Google's own encrypted (HTTPS) connections — answer **Yes** if the form asks about the app's traffic in general rather than per-data-type. |
| Can users request data deletion? | **Yes** — in-app, immediately, via Settings → Delete All Data. There is no account/server-side data to separately request deletion of, since none exists. |
| Does your app comply with Play's Families Policy? | Not applicable — this app is not directed at children and is not part of Play's Families program. |

## Independent security review

Answer **No** unless you've actually commissioned one — don't check this
box on the assumption that SQLCipher + Android Keystore counts as a
third-party review of *your* app; it doesn't. It's a true statement about
the encryption library, not an audit of this codebase.

## Committed to following Play's Families Policy?

**No** — this app targets general adult users (personal finance), not
children, and isn't designed or marketed for the Families program.

---

## Cross-check before you submit

1. Every "shared with third parties: Yes" answer above should trace to an
   actual SDK in `app/build.gradle` (AdMob, Play Billing) — if the form
   ever shows a data type you don't recognize collecting, that's usually a
   transitive SDK behavior worth investigating before answering blindly.
2. Re-read `docs/privacy-policy.html` after filling the real form and
   confirm every data type mentioned there also appears here, and vice
   versa. The two should never describe different facts.
3. If you add any new dependency later — analytics, crash reporting, a
   new ad network, cloud backup — **stop and update both this file and
   the policy before that build ships**, not after. This is exactly the
   drift `REQUIREMENTS.md` warns is the actual rejection trigger, not a
   hypothetical one.