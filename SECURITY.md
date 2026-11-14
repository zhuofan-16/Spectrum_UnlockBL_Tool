# Security Policy

## Scope

Spectrum UnlockBL Tool is a Bash script that converts a device identifier into a binary input and signs it with a private key using OpenSSL. The resulting signature is intended for a bootloader-unlock workflow.

Bootloader unlocking can erase device data, reduce device security, affect warranty or support eligibility, and—if performed incorrectly—make a device unusable. Only use this tool on devices you own or are explicitly authorized to service, and follow the device manufacturer's instructions.

This policy covers security vulnerabilities in this repository's source code, scripts, and published project artifacts. It does not provide support for unlocking a particular device or bypassing a manufacturer's authorization process.

## Supported Versions

This repository does not currently document a release support policy. Until maintainers publish supported release tags or branches, report security issues found in the latest revision of the default branch.

Do not assume that forks, modified copies, or older commits receive security updates.

## Reporting a Vulnerability

Please do not report suspected vulnerabilities in a public issue or pull request.

Use GitHub's private vulnerability reporting feature for this repository, if it is enabled. If it is unavailable, contact the repository maintainer privately through a contact method listed on the maintainer's GitHub profile. Do not include private keys, device identifiers, unlock tokens, or other sensitive material in a public report.

Please include, when safe to do so:

- The affected commit or release and relevant file
- A concise description of the issue and its potential impact
- Steps to reproduce the issue using test data or a non-production device
- Any relevant environment details, such as the operating system and OpenSSL version
- A suggested mitigation, if you have one

Allow the maintainer a reasonable opportunity to investigate and coordinate a fix before publicly disclosing the issue. Please do not access, modify, or unlock devices or use keys or identifiers that you do not own or have permission to use while investigating.

## Security Guidance for Users

- Obtain the script from a repository or release source you trust, and inspect it before running it. Do not run an unreviewed fork or modified copy with a sensitive private key.
- Use only a device identifier and signing key you are authorized to use. Do not share unlock tokens or identifiers publicly.
- Keep private keys out of the repository, command history, shared directories, and issue or pull request attachments. Restrict access to key files and use a trusted environment.
- Run the script from a dedicated working directory and check for existing files before execution. The script creates temporary files in its working directory and may remove an existing file at the requested signature output path.
- Verify the generated output and follow the device manufacturer's instructions before attempting an unlock. Back up important device data first.
- Do not use this tool to bypass access controls or to modify devices without authorization.

## Response and Disclosure

The project is maintained on a best-effort basis, so acknowledgment and remediation timelines are not guaranteed. The maintainer should coordinate any public disclosure with the reporter and publish fixes or security notices through the repository when appropriate.
