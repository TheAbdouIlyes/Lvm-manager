# Intelligent LVM Management System

This project demonstrates **automatic and intelligent management of LVM partitions** on a Lubuntu virtual machine.  
It includes **monitoring, cleaning, extending, and balancing LVs** to prevent storage issues.

---

## **Project Objective**

The goal of this project is to manage **LVM logical volumes (LVs)** efficiently by:

1. Monitoring LV usage.
2. Automatically cleaning unnecessary files.
3. Extending LVs from available VG space.
4. Moving files to other LVs if needed.
5. Alerting the administrator when manual intervention is required.

---

## **Project Structure**

### 1. Physical Disks (PVs)

Two additional virtual disks are used (20GB each):

- `/dev/sdb`
- `/dev/sdc`

These disks are initialized as **Physical Volumes**:

```bash
sudo pvcreate /dev/sdb /dev/sdc
