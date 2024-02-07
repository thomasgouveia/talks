---
theme: apple-basic
class: text-center
highlighter: shikiji
drawings:
  persist: false
transition: slide-up
title: 'Dynamic Database Credentials with HashiCorp Vault'
titleTemplate: '%s - Thomas Gouveia'
mdc: true
layout: intro
favicon: /vault-logo.svg
presenter: dev
download: true
author: Thomas Gouveia
remoteAssets: true
hideInToc: true
---

<div class="flex items-center justify-center">
  <img class="w-60 dark:hidden" src="/Vault_PrimaryLogo_Black_RGB.png" alt="Vault Press Kit Logo Black"/>
  <img class="w-60 hidden dark:block" src="/Vault_PrimaryLogo_White_RGB.png" alt="Vault Press Kit Logo White"/>
</div>

<span class="font-bold text-3xl">Dynamic Database Credentials with HashiCorp Vault</span>

<span class="text-sm text-gray-400">Presented by Thomas Gouveia</span>

---
hideInToc: true
---

# About Thomas

```bash
$ whoami
thomas.gouveia
```

<img src="https://avatars.githubusercontent.com/u/47056759?v=4" class="rounded-full w-24 mb-10" />

<v-click>

## Day Job

Lead DevOps Engineer at [IoTerop](https://ioterop.com).

</v-click>


<v-click>

## Socials

- GitHub: [@thomasgouveia](https://github.com/thomasgouveia)
- LinkedIn: [Thomas Gouveia](https://www.linkedin.com/in/thomas-gouveia/) 

</v-click>

<div class="fixed text-sm bottom-3 right-3">
    <SlideCurrentNo />
</div>

---
hideInToc: true
---

# Agenda

<Toc />

<div class="fixed text-sm bottom-3 right-3">
    <SlideCurrentNo />
</div>

---
layout: statement
transition: slide-left
---

<div class="fixed text-sm bottom-3 right-3">
    <SlideCurrentNo />
</div>

# Contextualization

---
hideInToc: true
transition: slide-left
---

<div class="fixed text-sm bottom-3 right-3">
    <SlideCurrentNo />
</div>

# What's a credential?

**Sensitive** information used to authenticate and authorize a user or system to access a specific resource or service.

<v-clicks>

- Username/password
- API Keys
- Certificates (mTLS, Email Signing, Code Signing, ...)
- And so on...

</v-clicks>

---
hideInToc: true
transition: slide-left
---

<div class="fixed text-sm bottom-3 right-3">
    <SlideCurrentNo />
</div>

# Let's take an example application

Below is the diagram of a basic 3 tier application:

<div class="flex relative items-center justify-center w-full">
    <img class="absolute" v-click=[1,2] src="/3-tier-1.png" alt="3 tier architecture schema 1">
    <img v-click=[2,3] src="/3-tier-2.png" alt="3 tier architecture schema 2 with credentials">
</div>

---
hideInToc: true
transition: slide-left
---

<div class="fixed text-sm bottom-3 right-3">
    <SlideCurrentNo />
</div>

# Deployment

From a developer point of view, when it comes to deployment: <v-click>**How can he retrieve and store the **credentials** needed by its application?**</v-click>

<v-click>

<img class="w-90" src="/mail-creds.png" alt="Mail for creds">

</v-click>

<v-click>

**Storage:**

- Environment variables
- Environment files
- Secret manager (if any)

</v-click>

---
layout: fact
hideInToc: true
transition: slide-left
---

<div class="fixed text-sm bottom-3 right-3">
    <SlideCurrentNo />
</div>

![KISS Gif](https://media2.giphy.com/media/iiD22fqgXUGKy7ZfDe/giphy.gif)

---
hideInToc: true
transition: slide-left
---

<div class="fixed text-sm bottom-3 right-3">
    <SlideCurrentNo />
</div>

# A little reminder

<v-clicks>

- Cloud adoption has grown exponentially in the last years
- Software architecture has evolved (Microservices, distributed systems, ...)
- **Containers are the new normal ([CNCF Annual Survey 2022](https://www.cncf.io/reports/cncf-annual-survey-2022/))**

</v-clicks>

<v-click>

<img class="h-60 mt-10" src="https://sysblog.informatique.univ-paris-diderot.fr/wp-content/uploads/2019/03/Kubernetes_Logo.png" alt="K8S Logo"/>

</v-click>

---
hideInToc: true
transition: slide-left
---

<div class="fixed text-sm bottom-3 right-3">
    <SlideCurrentNo />
</div>

# And now, our app looks like this

<img class="w-170" src="/microservices.png" alt="Microservices"/>

---
hideInToc: true
transition: slide-left
---

<div class="fixed text-sm bottom-3 right-3">
    <SlideCurrentNo />
</div>

# What's the difference?

<v-clicks>

- Stack complexity has considerably increased (Multiple DB servers, message queue, ...)
- Authentication & authorization can be placed everywhere (<span class="text-red-500">red arrows</span>)
- **We now need to deploy and configure N microservices instead of a single monolith**

</v-clicks>

<v-click>

## What about the credentials to access third-party services?

</v-click>

<v-clicks>

- Third-party components could be managed by different teams -> **Need to contact each component administrator**
- **Store them into Kubernetes secrets and mount them into the pods**

</v-clicks>

---
layout: statement
hideInToc: true
transition: slide-left
---

<div class="fixed text-sm bottom-3 right-3">
    <SlideCurrentNo />
</div>

Out of the box  <span class="font-bold text-red-400 text-2xl">Kubernetes security is a piece of sh**</span>.

<div class="flex justify-center">
    <img class="fixed left-115 top-48 w-12 h-12" src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/Kubernetes_logo_without_workmark.svg/2109px-Kubernetes_logo_without_workmark.svg.png" alt="K8S logo"/>
<span class="bg-white p-1 text-md fixed left-130 top-85">Attackers</span>
    <img class="h-90" src="https://media.tenor.com/6AH3e9jZlEQAAAAM/worst-security.gif" alt="GIF Worst Security"/>
</div>

<div class="text-xs">

Cloud Native Montpellier Chapter 6: [Horizontal Privileges Escalation in Kubernetes](https://drive.google.com/file/d/15Z7Nl7acsSlWGgqdPrJz0PbW3q6HTlsU/view?pli=1) by [LeoFVO](https://leofvo.me/)

</div>

---
hideInToc: true
transition: slide-left
---

<div class="fixed text-sm bottom-3 right-3">
    <SlideCurrentNo />
</div>

# A credential has leaked

<v-click>

![Nuclear Bomb](https://media0.giphy.com/media/oe33xf3B50fsc/giphy.gif)

</v-click>

<v-clicks>

- How can I avoid using Kubernetes secrets to store my credentials?
- Can I avoid using static credentials?
- Can I revoke and rotate a credential easily in a minimum of time?
- Can I automate the delivery of credentials to avoid manual overhead when new services need access?

</v-clicks>

---
hideInToc: true
transition: slide-up
---

<div class="fixed text-sm bottom-3 right-3">
    <SlideCurrentNo />
</div>

# What if?

You can set up a solution that can:
 
<v-clicks>

- Securely manage secrets for us, without the need to sync them into Kubernetes Secrets
- Dynamically generate credentials to access an external system
- Renew regularly the credentials and revoke it if expired
- Considerably reduce manual tasks to add/remove services

</v-clicks>

---
transition: slide-left
---

<div class="fixed text-sm bottom-3 right-3">
    <SlideCurrentNo />
</div>

# Say Hello to Vault 👋

<img src="/Vault_PrimaryLogo_Black_RGB.png" />

---
hideInToc: true
transition: slide-left
---

<div class="fixed text-sm bottom-3 right-3">
    <SlideCurrentNo />
</div>

# What is Vault?

Vault is an identity-based secrets and encryption management system.

**Secret**: A secret is anything that you want to tightly control access to, such as passwords, API encryption keys, SSH keys or certificates.

Vault provides encryption services that are gated by authentication and authorization methods.

**Key features:**

<v-clicks>

- **Secure Secret Storage**
- **Dynamic Secrets**
- **Data Encryption**
- **Leasing and renewal**
- **Revocation**

</v-clicks>

---
hideInToc: true
transition: slide-left
---

<div class="fixed text-sm bottom-3 right-3">
    <SlideCurrentNo />
</div>

# Architecture

<div class="flex items-center justify-center">
    <img class="w-180" src="/vault-architecture-diagram.png" alt="Vault Architecture Diagram">
</div>

---
hideInToc: true
transition: slide-left
---

<div class="fixed text-sm bottom-3 right-3">
    <SlideCurrentNo />
</div>

# Architecture

<v-clicks>

- Vault exposes an HTTP API: Vault UI, Vault CLI, Terraform provider, ...
- **Barrier** is the encryption layer of Vault, used to encrypt/decrypt Vault data.
- A Vault server always begins in a **sealed** state: <img class="w-120" src="/seal-unseal.png" alt="Vault Architecture Diagram">
- Vault supports auto unseal using a trusted cloud KMS or an HSM.

</v-clicks>

---
hideInToc: true
transition: slide-left
---

<div class="fixed text-sm bottom-3 right-3">
    <SlideCurrentNo />
</div>

# Secret Engine

- Store, generate or encrypt data
- Each secret engine is enabled at a **path**
- You can have multiple instances of a same engine at different paths
- Each engine receive a barrier view (like a chroot on Unix)

**Example of secret engines:**

<v-clicks>

- Key/Value
- **Databases** (👀)
- PKI Certificates
- Transit
- AWS
- ...

</v-clicks>

---
hideInToc: true
transition: slide-left
---

<div class="fixed text-sm bottom-3 right-3">
    <SlideCurrentNo />
</div>

# Authentication method

- Used to authenticate a client (human or machine) in Vault
- Generate a token that may have **policies** attached to it.
  
**Example of authentication methods:**

<v-clicks>

- Tokens
- Username/Password
- JWT/OIDC
- LDAP
- **Kubernetes** (👀)
- Kerberos
- ...

</v-clicks>

---
hideInToc: true
transition: slide-left
---

<div class="fixed text-sm bottom-3 right-3">
    <SlideCurrentNo />
</div>

# Policies

- Named ACL rules
- Allow to execute **actions** (create, read, update,...) on specific **paths**

<v-click>

Below a policy that grants read capabilities to the path `secret/foo`:

```hcl
path "secret/foo" {
  capabilities = ["read"]
}
```

</v-click>

---
hideInToc: true
transition: slide-left
---

# Leases

<v-clicks>

- **All dynamic secrets in Vault are required to have a lease**
- Metadata containing information (duration, renewability, ...)
- Vault promises that the data will be valid for the given duration (TTL)
- Vault automatically revoke the data when a lease is expired
- Can be revoked, renewed

</v-clicks>

---
hideInToc: true
transition: slide-left
---

<div class="fixed text-sm bottom-3 right-3">
    <SlideCurrentNo />
</div>

# Overview

<div class="flex items-center justify-center">
    <img class="w-180" src="/vault-triangle.png" alt="Vault Architecture Diagram">
</div>

---
hideInToc: true
transition: slide-left
---

<div class="fixed text-sm bottom-3 right-3">
    <SlideCurrentNo />
</div>

# Database Secret Engine

- Credentials generation for multiple databases systems (Elasticsearch, PostgreSQL, MongoDB)
- Easy to extend via the plugin interface

<img class="h-90" src="/vault-dynamic-db.png" alt="Vault Dynamic Credentials">

---
hideInToc: true
transition: slide-up
---

<div class="fixed text-sm bottom-3 right-3">
    <SlideCurrentNo />
</div>

# Kubernetes Authentication

- Authenticate Pods via their service account token

<img class="h-90" src="/kube-auth.png" alt="Kubernetes Authentication">

---
layout: statement
transition: slide-left
---

<div class="fixed text-sm bottom-3 right-3">
    <SlideCurrentNo />
</div>

# Let's practice a little 🤙

---
hideInToc: true
transition: slide-left
---

<div class="fixed text-sm bottom-3 right-3">
    <SlideCurrentNo />
</div>

# What do we want to build?

<img class="h-90" src="/what-we-want-to-build.png" alt="What we want to build">

---
hideInToc: true
transition: slide-left
---

<div class="fixed text-sm bottom-3 right-3">
    <SlideCurrentNo />
</div>

# Vault Injector

- [Kubernetes Mutation Webhook Controller](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/) that intercepts pod events and applies mutation to the pod (Init and Sidecar containers)
- App is not aware of Vault (loosely coupled)
- Easy to set up (pod annotations)

<v-click>

<img class="h-70" alt="Vault Injector" src="/vault-injector.png">

</v-click>

---
hideInToc: true
layout: statement
---

# Live demo

---
layout: statement
transition: slide-left
---

# Wrap-up 

---
hideInToc: true
transition: slide-left
---

# Wrap-up

- Our pods have unique, short-lived credentials
- Adding a new service requires only to create two roles in Vault and a SA in Kubernetes
- Several solutions are available to gracefully renew the credentials
- This workflow can be also applied to humans to give temporary access to DBs

---
hideInToc: true
transition: slide-left
---

# Recommendations

<v-clicks>
 
- **Vault is a critical component and must be considered as a SPOF, [harden it](https://developer.hashicorp.com/vault/tutorials/operations/production-hardening) carefully**
- Carefully define your lease durations (remember: the shorter is better!)
- Always use the least privilege for your different Vault roles
- If you run it in **Kubernetes**, deploy it in a dedicated cluster
- Enable the auto unseal feature
- Do not expose the Vault API/UI publicly
- Use Terraform to provision your Vault resources

</v-clicks>

---
hideInToc: true
layout: statement
---

# Thank you

Any questions?

<div class="flex items-center space-x-15">
    <div>
        <img class="w-50" src="/qr-talk.png" alt="QR Code to go to the talk link">
        <a href="https://thomasgouveia.github.io/talks/dynamic-database-credentials-with-hashicorp-vault">Slides</a>
    </div>
    <div>
        <img class="w-50" src="/qr-demo-repo.png" alt="QR Code to go to the talk demo repository on GitHub">
        <a href="https://github.com/thomasgouveia/vault-dynamic-mongodb-credentials">GitHub Demo</a>
    </div>
</div>