using UnityEngine;
using UnityEngine.UI;

public class PanelActivator : MonoBehaviour
{
    [SerializeField] private GameObject[] mainElementsUI;
    [Space]
    [SerializeField] private GameObject inventoryPanel;
    [SerializeField] private Button activeInventoryButton;
    [Space]
    [SerializeField] private GameObject pausePanel;
    [SerializeField] private Button activePauseButton;
    [Space]
    [SerializeField] private PlayerStats playerStats;
    [SerializeField] private GameObject deadPanel;
    [SerializeField] private GameObject[] additionalPanels;

    private void OnEnable()
    {
        playerStats.PlayerDaadEvent += ActivePanelDead;
    }

    private void OnDisable()
    {
        playerStats.PlayerDaadEvent -= ActivePanelDead;
    }

    private void Start()
    {
        DeactivateAllPanel();
    }

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.Tab))
            SetActiveInventory(!inventoryPanel.activeSelf);

        if (Input.GetKeyDown(KeyCode.Escape))
            SetActivePause(!pausePanel.activeSelf);
    }

    public void SetActiveInventory(bool active)
    {
        if (IsCanOpen() == false) return;

        PlayTime(true);
        DeactivateAllPanel();
        inventoryPanel.SetActive(active);
        OpenUI(active);
    }

    public void SetActivePause(bool active)
    {
        if (IsCanOpen() == false) return;

        DeactivateAllPanel();
        pausePanel.SetActive(active);

        PlayTime(!active);

        OpenUI(active);
    }

    private void SetActivEmainElements(bool active)
    {
        for (int i = 0; i < mainElementsUI.Length; i++)
        {
            if (mainElementsUI[i])
                mainElementsUI[i].SetActive(active);
        }
    }

    private void ActivePanelDead()
    {
        DeactivateAllPanel();
        OpenUI(true);
        deadPanel.SetActive(true);
    }

    private void OpenUI(bool active)
    {
        ManagerUI.Instance.OpenUI(active);
        SetActivEmainElements(!active);
    }

    private void PlayTime(bool active)
    {
        if (active) TimeScaleController.Play();
        else TimeScaleController.Stop();
    }

    public void DeactivateAllPanel()
    {
        inventoryPanel.SetActive(false);
        pausePanel.SetActive(false);

        OpenUI(false);

        if (additionalPanels != null)
        {
            if (additionalPanels.Length > 0)
            {
                for (int i = 0; i < additionalPanels.Length; i++)
                {
                    if (additionalPanels[i])
                        additionalPanels[i].SetActive(false);
                }
            }
        }
    }

    private bool IsCanOpen()
    {
        if (playerStats)
        {
            if (playerStats.IsDead)
                return false;
        }

        return true;
    }

}
